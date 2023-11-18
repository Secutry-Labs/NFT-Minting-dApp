// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

contract MySmartNFT is  ERC721URIStorage {
    uint256 private _tokenIdTracker;

    constructor() ERC721("Secutry NFT's", "Secutry Corp.") {
        console.log("This is my NFT contract. Woah!");
        _tokenIdTracker = 0; 
    }

    function makeAnEpicNFT() public {
        uint256 newItemId = _tokenIdTracker;
        _safeMint(msg.sender, newItemId);
        tokenURI(newItemId);
        _tokenIdTracker += 1; 
    }

    function tokenURI(uint256 _tokenId) public view override returns (string memory) {
        address owner = ownerOf(_tokenId);
        require(owner != address(0), "Token ID does not exist");
        console.log("An NFT w/ ID %s has been minted to %s", _tokenId, owner);
        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                "eyJuYW1lIjoiU2VjdXRyeSBMb2dvIiwiZGVzY3JpcHRpb24iOiJBbiBORlQgZnJvbSB0aGUgaGlnaGx5IGFjY2xhaW1hYmxlIFNlY3V0cnkgQ29ycG9yYXRpb24iLCJpbWFnZSI6ImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEhOMlp5QjNhV1IwYUQwaU16RTNNeUlnYUdWcFoyaDBQU0l6TVRFMElpQjJhV1YzUW05NFBTSXdJREFnTXpFM015QXpNVEUwSWlCbWFXeHNQU0p1YjI1bElpQjRiV3h1Y3owaWFIUjBjRG92TDNkM2R5NTNNeTV2Y21jdk1qQXdNQzl6ZG1jaVBnbzhaeUJtYVd4MFpYSTlJblZ5YkNnalptbHNkR1Z5TUY5a1psOHhNVFJmTWpjcElqNEtQSEJoZEdnZ1pEMGlUVEl4TWk0NU56RWdOamc1TGpRM05Fd3pNVFU1TGpNeklERTVOVFl1TVRsTU1qazFOeTR3TXlBeU5ERTVMakUxVERFd0xqWTJPVGtnTVRFMU1pNDBORXd5TVRJdU9UY3hJRFk0T1M0ME56UmFJaUJtYVd4c1BTSjFjbXdvSTNCaGFXNTBNRjlzYVc1bFlYSmZNVEUwWHpJM0tTSXZQZ284Y0dGMGFDQmtQU0pOTXpFMk1pNHpPU0F4T1RVM0xqRTVRek13T1RFdU16TWdNakkxTWk0M0lESTVNamt1TlRFZ01qVXhPQzR4SURJMk9UY3VNemtnTWpjeE9TNDRNVU15TkRZMUxqSTRJREk1TWpFdU5UTWdNakUzTXk0eklETXdOVEF1TlRFZ01UZzFPQzR6TnlBek1Ea3dMalEwUXpFMU5ETXVORFFnTXpFek1DNHpPQ0F4TWpFNUxqY3lJRE13TnprdU5EY2dPVEk0TGpFeU55QXlPVFEwTGpFMlF6WXpOaTQxTXpnZ01qZ3dPQzQ0TkNBek9UQXVNVGd5SURJMU9UVXVNakVnTWpJd0xqSXhNeUF5TXpNd0xqSTJURFl6TUM0ME55QXlNRGs0TGpJelF6YzBPUzQwTkRnZ01qSTRNeTQzSURreU1TNDRPVGNnTWpRek15NHlOQ0F4TVRJMkxqQXhJREkxTWpjdU9UWkRNVE16TUM0eE1pQXlOakl5TGpZNElERTFOVFl1TnpNZ01qWTFPQzR6TVNBeE56YzNMakU0SURJMk16QXVNelpETVRrNU55NDJNeUF5TmpBeUxqUXhJREl5TURJdU1ERWdNalV4TWk0eE1pQXlNelkwTGpRNUlESXpOekF1T1RKRE1qVXlOaTQ1TnlBeU1qSTVMamN5SURJMk5EQXVNalVnTWpBME15NDVOQ0F5TmpnNUxqazVJREU0TXpjdU1EaE1NekUyTWk0ek9TQXhPVFUzTGpFNVdpSWdabWxzYkQwaWRYSnNLQ053WVdsdWRERmZiR2x1WldGeVh6RXhORjh5TnlraUx6NEtQSEJoZEdnZ1pEMGlUVEk1TlRVdU1qWWdOemd6TGpReVF6STNPRFV1TWprZ05URTRMalEzTWlBeU5UTTRMamt6SURNd05DNDRNelFnTWpJME55NHpOQ0F4TmprdU5USXlRekU1TlRVdU56VWdNelF1TWpFd05DQXhOak15TGpBeklDMHhOaTQyT1RnZ01UTXhOeTR4SURJekxqSXpORFpETVRBd01pNHhPQ0EyTXk0eE5qY3lJRGN4TUM0eE9UUWdNVGt5TGpFME55QTBOemd1TURnZ016a3pMamcyTlVNeU5EVXVPVFkySURVNU5TNDFPRElnT0RRdU1UUTBNaUE0TmpBdU9UYzNJREV6TGpBM09TQXhNVFUyTGpRNVREUTROUzQwTnpZZ01USTNOaTQxT1VNMU16VXVNakl5SURFd05qa3VOelFnTmpRNExqUTVOaUE0T0RNdU9UVTVJRGd4TUM0NU56WWdOelF5TGpjMU4wTTVOek11TkRVMklEWXdNUzQxTlRVZ01URTNOeTQ0TkNBMU1URXVNalk1SURFek9UZ3VNamtnTkRnekxqTXhOa014TmpFNExqYzBJRFExTlM0ek5qTWdNVGcwTlM0ek5TQTBPVEF1T1RrNUlESXdORGt1TkRZZ05UZzFMamN4TjBNeU1qVXpMalUzSURZNE1DNDBNellnTWpReU5pNHdNaUE0TWprdU9UZ3lJREkxTkRVZ01UQXhOUzQwTlV3eU9UVTFMakkySURjNE15NDBNbG9pSUdacGJHdzlJblZ5YkNnamNHRnBiblF5WDJ4cGJtVmhjbDh4TVRSZk1qY3BJaTgrQ2p3dlp6NEtQR1JsWm5NK0NqeG1hV3gwWlhJZ2FXUTlJbVpwYkhSbGNqQmZaR1pmTVRFMFh6STNJaUI0UFNJd0xqWTJOemsyT1NJZ2VUMGlNQ0lnZDJsa2RHZzlJak14TnpFdU56SWlJR2hsYVdkb2REMGlNekV4TXk0Mk9DSWdabWxzZEdWeVZXNXBkSE05SW5WelpYSlRjR0ZqWlU5dVZYTmxJaUJqYjJ4dmNpMXBiblJsY25CdmJHRjBhVzl1TFdacGJIUmxjbk05SW5OU1IwSWlQZ284Wm1WR2JHOXZaQ0JtYkc5dlpDMXZjR0ZqYVhSNVBTSXdJaUJ5WlhOMWJIUTlJa0poWTJ0bmNtOTFibVJKYldGblpVWnBlQ0l2UGdvOFptVkRiMnh2Y2sxaGRISnBlQ0JwYmowaVUyOTFjbU5sUVd4d2FHRWlJSFI1Y0dVOUltMWhkSEpwZUNJZ2RtRnNkV1Z6UFNJd0lEQWdNQ0F3SURBZ01DQXdJREFnTUNBd0lEQWdNQ0F3SURBZ01DQXdJREFnTUNBeE1qY2dNQ0lnY21WemRXeDBQU0pvWVhKa1FXeHdhR0VpTHo0S1BHWmxUMlptYzJWMEx6NEtQR1psUjJGMWMzTnBZVzVDYkhWeUlITjBaRVJsZG1saGRHbHZiajBpTUM0MUlpOCtDanhtWlVOdmJYQnZjMmwwWlNCcGJqSTlJbWhoY21SQmJIQm9ZU0lnYjNCbGNtRjBiM0k5SW05MWRDSXZQZ284Wm1WRGIyeHZjazFoZEhKcGVDQjBlWEJsUFNKdFlYUnlhWGdpSUhaaGJIVmxjejBpTUNBd0lEQWdNQ0F3SURBZ01DQXdJREFnTUNBd0lEQWdNQ0F3SURBZ01DQXdJREFnTVNBd0lpOCtDanhtWlVKc1pXNWtJRzF2WkdVOUltNXZjbTFoYkNJZ2FXNHlQU0pDWVdOclozSnZkVzVrU1cxaFoyVkdhWGdpSUhKbGMzVnNkRDBpWldabVpXTjBNVjlrY205d1UyaGhaRzkzWHpFeE5GOHlOeUl2UGdvOFptVkNiR1Z1WkNCdGIyUmxQU0p1YjNKdFlXd2lJR2x1UFNKVGIzVnlZMlZIY21Gd2FHbGpJaUJwYmpJOUltVm1abVZqZERGZlpISnZjRk5vWVdSdmQxOHhNVFJmTWpjaUlISmxjM1ZzZEQwaWMyaGhjR1VpTHo0S1BHWmxSMkYxYzNOcFlXNUNiSFZ5SUhOMFpFUmxkbWxoZEdsdmJqMGlOU0lnY21WemRXeDBQU0psWm1abFkzUXlYMlp2Y21WbmNtOTFibVJDYkhWeVh6RXhORjh5TnlJdlBnbzhMMlpwYkhSbGNqNEtQR3hwYm1WaGNrZHlZV1JwWlc1MElHbGtQU0p3WVdsdWREQmZiR2x1WldGeVh6RXhORjh5TnlJZ2VERTlJakUxTWpZdU1UTWlJSGt4UFNJeE1DSWdlREk5SWpFMU1qWXVNVE1pSUhreVBTSXpNVEF6TGpZNElpQm5jbUZrYVdWdWRGVnVhWFJ6UFNKMWMyVnlVM0JoWTJWUGJsVnpaU0krQ2p4emRHOXdJSE4wYjNBdFkyOXNiM0k5SWlNd01FWXlOakFpTHo0S1BITjBiM0FnYjJabWMyVjBQU0l3TGpnMU9UTTNOU0lnYzNSdmNDMWpiMnh2Y2owaUl6QTFOelZGTmlJdlBnbzhMMnhwYm1WaGNrZHlZV1JwWlc1MFBnbzhiR2x1WldGeVIzSmhaR2xsYm5RZ2FXUTlJbkJoYVc1ME1WOXNhVzVsWVhKZk1URTBYekkzSWlCNE1UMGlNVFV5Tmk0eE15SWdlVEU5SWpFd0lpQjRNajBpTVRVeU5pNHhNeUlnZVRJOUlqTXhNRE11TmpnaUlHZHlZV1JwWlc1MFZXNXBkSE05SW5WelpYSlRjR0ZqWlU5dVZYTmxJajRLUEhOMGIzQWdjM1J2Y0MxamIyeHZjajBpSXpBd1JqSTJNQ0l2UGdvOGMzUnZjQ0J2Wm1aelpYUTlJakF1T0RVNU16YzFJaUJ6ZEc5d0xXTnZiRzl5UFNJak1EVTNOVVUySWk4K0Nqd3ZiR2x1WldGeVIzSmhaR2xsYm5RK0NqeHNhVzVsWVhKSGNtRmthV1Z1ZENCcFpEMGljR0ZwYm5ReVgyeHBibVZoY2w4eE1UUmZNamNpSUhneFBTSXhOVEkyTGpFeklpQjVNVDBpTVRBaUlIZ3lQU0l4TlRJMkxqRXpJaUI1TWowaU16RXdNeTQyT0NJZ1ozSmhaR2xsYm5SVmJtbDBjejBpZFhObGNsTndZV05sVDI1VmMyVWlQZ284YzNSdmNDQnpkRzl3TFdOdmJHOXlQU0lqTURCR01qWXdJaTgrQ2p4emRHOXdJRzltWm5ObGREMGlNQzQ0TlRrek56VWlJSE4wYjNBdFkyOXNiM0k5SWlNd05UYzFSVFlpTHo0S1BDOXNhVzVsWVhKSGNtRmthV1Z1ZEQ0S1BDOWtaV1p6UGdvOEwzTjJaejRLIn0="
            )
        );
    }

}
