Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07477311CC8
	for <lists+linux-spi@lfdr.de>; Sat,  6 Feb 2021 11:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhBFK57 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 6 Feb 2021 05:57:59 -0500
Received: from mail-eopbgr80090.outbound.protection.outlook.com ([40.107.8.90]:53365
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229507AbhBFK55 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 6 Feb 2021 05:57:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwXvhEpr7gMbYs+5aHMYdCb5haHsvlPJOsMx1elFNvdlHR2haLuI+mgS6hUIVP0n9JQ/K3NA5papM57reYp9FjU3meynD1jWjZFQSywa7VcebkLuHEjhvyD2Lc77ZuKSfpuE87nLfVy4dHjGf9YDthBlipA4xYKC1cRKydX3qQanGFrLT5tTrgO0JfA4lh93/uRhCPNDzuPmA2S7uSWutHecFXbpkeOxdyxHraf1dl03i2FPAo1vxD+8a6LtIDrptwx9pydHoMLIok549Te39phVUhAxGkgWgQqYZxFCU+8hVNgs+AoWPYNiKYiuT7WCwEzpcoocCV+sjhU0ytkYMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a46oDooQXAFAzQBtL/erg5P5Ne83sl2chu1xEd7MNAg=;
 b=I+Or+7qMQkQhX/kL08/iStbn1WQRSPGI6/4kmdrmIpOiY1N3npljrCdHaWla4PNV44TgD2mvbHbPJ8k7o/pZU61LK0zHF1FCkR/8mnmqExTe9Yw8ql84ktPugYyMKK9jYwrVa0Zv1SJuFSiUReU+xfJZL3/WDxJ2h00vauXzCVd179qcmG3h6Pr1LfwA8QJMP+ccBCkuOBRzmb3rYSnjUikdo08cSgJoiTnhiT5nduehdNINPn3crMel4tI8z/91rSDY+jJkPMfYsjN1K8DDQfh8uezFG2aaWEG1QwVljLSZ3qxNN5OgDJlyHon5AVsJXEmdT0PO55GqesMLr94nHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachi-powergrids.com; dmarc=pass action=none
 header.from=hitachi-powergrids.com; dkim=pass
 header.d=hitachi-powergrids.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hitachi-powergrids.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a46oDooQXAFAzQBtL/erg5P5Ne83sl2chu1xEd7MNAg=;
 b=KPU9ckN8xXRXF1f7YEcFQf/Y6rP1MyWdNSd05xQNgWiFIJO869ebNuMVo4NvnBO9s8prOBb+E4iKj8fndeIZLNm9KoI05sJUG6Jiu7/L71TgikpypcYoXIYEy1a9/METzV/CK6btaNYLtqQjSwxaiZy3aS4KtTrjxsofK4RZ9SE=
Received: from VI1PR06MB4029.eurprd06.prod.outlook.com (2603:10a6:802:5d::10)
 by VI1PR0601MB2685.eurprd06.prod.outlook.com (2603:10a6:800:8b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.22; Sat, 6 Feb
 2021 10:57:05 +0000
Received: from VI1PR06MB4029.eurprd06.prod.outlook.com
 ([fe80::5122:a590:b5fb:658e]) by VI1PR06MB4029.eurprd06.prod.outlook.com
 ([fe80::5122:a590:b5fb:658e%4]) with mapi id 15.20.3825.028; Sat, 6 Feb 2021
 10:57:04 +0000
From:   Aleksandar Gerasimovski 
        <aleksandar.gerasimovski@hitachi-powergrids.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: RE: [PATCH] spi: tools: fix input string formatting
Thread-Topic: [PATCH] spi: tools: fix input string formatting
Thread-Index: Adb7lWXMIZfEJF6fRI2btRVdFMCGkgARWziAACbAHOA=
Date:   Sat, 6 Feb 2021 10:57:04 +0000
Message-ID: <VI1PR06MB4029DDA88C93EFBA0F69D838D2B19@VI1PR06MB4029.eurprd06.prod.outlook.com>
References: <VI1PR06MB402928E3B0E4C887104BCE22D2B29@VI1PR06MB4029.eurprd06.prod.outlook.com>
 <20210205162031.GG4720@sirena.org.uk>
In-Reply-To: <20210205162031.GG4720@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-processedbytemplafy: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=hitachi-powergrids.com;
x-originating-ip: [2a02:aa10:4200:d580:c8ff:aaa2:f5d8:c075]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff9109ec-19f9-4a77-a503-08d8ca8df0aa
x-ms-traffictypediagnostic: VI1PR0601MB2685:
x-microsoft-antispam-prvs: <VI1PR0601MB26859FC6AB7044DA9B1E4043D2B19@VI1PR0601MB2685.eurprd06.prod.outlook.com>
x-abb-o365-outbound: ABBOUTBOUND1
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fBhu3WzBNSR1wmkRLkQOVBeCR6DDW77P22wbszvAn4jLjWo9KPH9DIwe9ve5nenRRtQQ6GLml/x2H9Sb60jBMEUSNh+oV6CX5pZENZ6filc0WGISVokCI1Qq1nYOVQQ6dBFVgy6azJ7DP6nzvG4Fgpo8aWf6YZEMCl/yb+Pa9/Vs4dg9io2JxwJF3N2QmzbbPCQnN5SjwLiAlcNLv8+5H+k1P4jVMfDqtlL41q8SpVtRF9YFVADVKgmcgp3kaUZNpvTGMcHsYN7Z+02PORcqXbqRQZvJRI3kzFACZQhkyz1wKoBeHI75Gd/2lpcy0vI22esZ4wbHKPjg35kJwi68Fx6hYLKTE9oNGJPuxpwT30d/qePw6ug1hqQsDjJ3V3dQOPa9+Lgt0klTHykTLi7/lad4S8xJmjdcmAsQlTUyFpf1s97Ienv1ZsszdeYavfuqgasn0Fij4q7KP/cqkfGlw+1tqi9rGTdMt3R62Ou1jTuOg3SKUROe7gFCNZxazs86iSufnmhM1OT917nV2l/Rzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR06MB4029.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(366004)(39850400004)(2906002)(71200400001)(6916009)(33656002)(76116006)(55016002)(186003)(66476007)(66556008)(64756008)(66446008)(9686003)(53546011)(86362001)(66946007)(6506007)(83380400001)(5660300002)(8676002)(44832011)(8936002)(316002)(52536014)(478600001)(4326008)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XlfdUL775M7QkPxmjo54ZtV9CivvdYwCsjrZklglt9PB+8msqaX4S5wE/Y2O?=
 =?us-ascii?Q?pkF+1W1mLzxXLOCUXf0XlTQ2V2JB2SvK+7Wz7FZrjEHkiAWDGgOsMGSMyB0I?=
 =?us-ascii?Q?s6AG2uKZRQOHhxuRQ5WI+0ZevWFVQvPERV9zQGGFCbphHzxkVkUEmgjgoluA?=
 =?us-ascii?Q?TS9U0ry/tHFIbsEGUDv/1ZxGhOOnLozONYNBW9uLZUeYilC64Ijgnr2aMeo1?=
 =?us-ascii?Q?EcIN90K96Zb21TDED7dxjgUxrlTqqFxjgc0WKgmMbou2wtgLWd28Yaq1YWHA?=
 =?us-ascii?Q?su3ZpIqGA2DhWrHlIcV2w7P3RpvwTyY0P7TyQjUqeBWmIaVPaUOW75wGmxcX?=
 =?us-ascii?Q?yIDcNVfFssP5e1gH+Zy2TtDijIDzw5cKWvrB1Az9QYcWMu96uAc0hs9EJKpl?=
 =?us-ascii?Q?BH7pe59DKKwP1HDNK3I4MOYA3dcY6Z2Kq4nf9GHWErEq1+8K9VQHTaRD6ZXh?=
 =?us-ascii?Q?EQR4wK2sLzllHX66muOEXqj6mXb5raAkmZeeE6eiUch4LjMNkgDWAiEBkDBl?=
 =?us-ascii?Q?bcMRT7caoMGIZprwLNzWwVwzt5MDY56GAkpgiaEQ6cROpt2b5AxzZ4JcMHe3?=
 =?us-ascii?Q?n2w60CFOnVI/cshjDDE68aylvj5iGzQQqikqM4T/mNthZabDakS6eT5l4aw/?=
 =?us-ascii?Q?5CW27mEXywD6BLJDXX0Wl8lyk9QhAOYJPErgGVMmhcbqtr+HqvvxpxyiNOHO?=
 =?us-ascii?Q?WIbgSvF9Q/2BIaVwBAImSzPZgbkc+w9CFPbGQBH7EIL0iA3Fx3hDiE4YbBkW?=
 =?us-ascii?Q?SGMCg540CujwW/90X4/WDnv1vLuxs0Md6znAUxqB43y80wRJtYNenYk/A3Zr?=
 =?us-ascii?Q?7Vx/hvVdfI50qhK3bxLC5scJd8lXiJAIHLJZhwE5ZWuH34h3J0iM/+gr2vEI?=
 =?us-ascii?Q?8Z2H3BoQt9DQUBZYnlWJ7waMenlfGRUZiRGYqVKi0C/sUmDejE/7c44QPrgS?=
 =?us-ascii?Q?PGRYPFtiwu4Ycq7kKlbMrCLfVDtQBqfTKogmBY/YGmF5Fi+gyQ+8rE1wOEU9?=
 =?us-ascii?Q?gDBzY/xqi45UppRxPFxjQHhSmfWDK3p9XM2fz+UvttAEh9zWQ4f4y+7y46ec?=
 =?us-ascii?Q?B0IWb18cID3Yf/k19FaPcQotmtnKHfP9d5FvxiIvuDU+aqyswdnof9Lq3z0T?=
 =?us-ascii?Q?Tq8e3hHGTsaoWgEclGauOLnuiiEb9EhnpxHZINK7t1P2V9k72KDqVK1348Px?=
 =?us-ascii?Q?LxD/EqtNkeDU0BzDrl5YqyYq6qC6/vN9vE2nvvo0sNV0wJTC0D0iLh7VNQwV?=
 =?us-ascii?Q?CNye903OaRnM71SzfSzatL1QVilN1Ng/bORWe8C4ZG+yn7oS56myP40AF1G7?=
 =?us-ascii?Q?S3UK8K6o74zQ10stFfwqsllsr5lvWPfUXBQb2nL7Z5uraj48rcTt4T8iRrwD?=
 =?us-ascii?Q?uIKEj/zW5Bofknus3U7dj7RISxIn?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hitachi-powergrids.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR06MB4029.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff9109ec-19f9-4a77-a503-08d8ca8df0aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2021 10:57:04.8840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7831e6d9-dc6c-4cd1-9ec6-1dc2b4133195
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 546WLxpWEyz6bINYxMbgNsgtyneUFIpXRTG8QF88U3ZFu5dN3fqPw5SqFTL8/QPceECWgfHBphYNoI6H6k+2hK9IPY8VdO5eU4Nk/OMiczKhrdvBupsgxZ46dXkTyv0WtnhazWxkWmWcD9VCjiX5Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0601MB2685
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

Thanks for the feedback, see inline:

-----Original Message-----
From: Mark Brown <broonie@kernel.org>=20
Sent: Freitag, 5. Februar 2021 17:21
To: Aleksandar Gerasimovski <aleksandar.gerasimovski@hitachi-powergrids.com=
>
Cc: linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: tools: fix input string formatting

On Fri, Feb 05, 2021 at 08:04:10AM +0000, Aleksandar Gerasimovski wrote:
> The actual unescape implementation has two bugs:

This is two bugs with two separate fixes, it should be two separate patches=
.
AG: Ok, I can provide two patches if needed.

> 1. quotation marks from the input string are not removed and are sent
>   to the spidev, e.g: input string: \"\\xFE\\x01\" will be sent to the
>   spidev as 0x22 0xfe 0x01 0x22

It is not clear to me what the issue you see here is - could you be more sp=
ecific about where you see this input string and why you believe that the h=
andling is incorrect?  After going through the shell the above will be

	"\xFE\x01"

which includes quotation marks which then get sent on to the device.

>  /*
>   *  Unescape - process hexadecimal escape character
> - *      converts shell input "\x23" -> 0x23
> + *      converts shell input "\\x23" -> 0x23
>   */

This is changing the documented input format and not mentioned in the chang=
elog?
AG: Ok my bad!

> +		if (*src =3D=3D '"') {
> +			src++;
> +			continue;
> +		}
>  		if (*src =3D=3D '\\' && *(src+1) =3D=3D 'x') {
>  			match =3D sscanf(src + 2, "%2x", &ch);
>  			if (!match)

This just appears to ignore quotes which isn't at all what I'd expect?
AG: to be sure we understand each other, you expect quotes to be sent to sp=
i as well? That's expected by design behavior?
Is there any possibility to avoid sending them then?

> @@ -108,6 +112,9 @@ static int unescape(char *_dst, char *_src, size_t le=
n)
>  			src +=3D 4;
>  			*dst++ =3D (unsigned char)ch;
>  		} else {
> +			match =3D sscanf(src, "%2d", &ch);
> +			if (!match)
> +				pabort("malformed input string");
>  			*dst++ =3D *src++;

This appears to be requiring that anything passed into unescape() be a numb=
er which isn't something we'd obviously want?  I'd expect the function to u=
nescape things, not to do other random validation which may or may not be a=
ppropriate in context.
AG: so by design is expected that everything is accepted here, e.g \"1234qw=
ert\\xde\\xad\"? If yes than I understood this tool wrongly.
