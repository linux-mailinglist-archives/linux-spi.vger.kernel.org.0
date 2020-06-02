Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A2B1EBEB6
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jun 2020 17:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgFBPFt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jun 2020 11:05:49 -0400
Received: from mout.web.de ([212.227.17.12]:46521 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgFBPFt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 2 Jun 2020 11:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591110328;
        bh=bhZEi41r2y1iJ1g/gk1RdYXNv9UKK7ix9XvWCB+cAow=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Tu1ZpeECbW7xsVW53xikmFrrX6DrF2souPzWhWi2nKCrD1qhQZUz4ferTqYikJpZT
         mbdnmYa7YHnkkVMrvoR/6avO7PFrZGBEGznE2HyD06zjNsEPFruHvFhYiTzst1LsRu
         H/mt/b1K/7F/cwsYWHHuw+lMwNfVGfiKGy7N97Mg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.186.246]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LmLc6-1j6WTq1wyQ-00a0VX; Tue, 02
 Jun 2020 17:05:28 +0200
Subject: Re: spi: spi-ti-qspi: call pm_runtime_put on pm_runtime_get failure
To:     Mark Brown <broonie@kernel.org>,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        linux-spi@vger.kernel.org
Cc:     Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <26028f50-3fb8-eb08-3c9f-08ada018bf9e@web.de>
 <20200602094947.GA5684@sirena.org.uk>
 <1c13e0ec-e50f-9eea-5704-052d2d682727@web.de>
 <20200602141306.GH5684@sirena.org.uk>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <cc8e1397-c605-d73e-363e-9d2ddfb9ae16@web.de>
Date:   Tue, 2 Jun 2020 17:05:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200602141306.GH5684@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yl/nIGA4a6n3EhxK5K/ZywDLKCNXZ5IsFzAdbU3Yqg7s0NH5c7r
 Ub6DGFnRqrluB6Hi2udFIWWZeV2wxTboiaRCBvdRcbb96Zmn1BE8cBXGyZX49BaMADptujJ
 FCcOVLIWhIq3O1P1rCKR984oGXNT6VwBjoX5l0ZXZJfjIllAz/+UgEvuSA5GvB9HCBwUjag
 fL27JPEFOwRo9/PsZPrFQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:f8bapepscD8=:fwgwBUbyq4yeYGNkmncv65
 hcGndfSo6v4wR2trC7M68ILA4EOKNLpZdKsSapy4sBAZmUwtpPPyENxkYZS17XzrwJIV6tBeL
 s6yfLLMDREZ4ZfTw4D73AJonUuZqrCTxivJZkEhi4WVN6BAXq4fCG6/UqERp/9bTGj7E+/87J
 f9GD4sj769Nl2DgHbi31m+ihQv2q0GTkK8mVBauebyDYn/L3XoYC8OybC0+m7f/B/aC2jOVgi
 6GItorqW+3wz41nwKEbB4/0+ESCE19e4u9v4gzOXD0VLNG45qW/KoPzbU7LOb/X7mH2aChrsz
 pGJEID/nA1Z6NLeEFT1fWQJepslbzLkk+1I1rby87ZM9DVOsHILm+l6hseuVGxsa8GBa8KWt5
 vWz5LJS12pEjdUMmbPun3G1R7b1xhN3gqpiSKFOQtsbS49jJ9RpX1XWNJBV40Gs+lpKRXLp6s
 ZaDAKuF7yaSxDsrayRwbOekGCSo4YsN65yoTpTRCq2AmsEArNfy+TIGZw3BQsdD3sKVIk3B44
 q0PtYXH+Ijd98SIS89mvCM3G64TdbrNgzYim+nXRrhBB/7Cd5St8NgjltO8+r3qTTodoB/EPe
 gxrqGBD/pzPY6/AQDRGsEtq57NmpFxdP3AHmyQnR33bu0foqGuRYNVwdgWePknkmACxa5v0M1
 h/aIi8Os8SP2EIkDUJyxzPqGqvTb7qxIIZ23oUTGHS/4SHd1THOazF5yHD6R7FTN+m+lcueyq
 ofjgGarGk5o72xdeqCC8Z/z9y+VdBIpYpo5kHHuHNPFgd/EO7nEvfWXxjxvbFXkIWpMV9MZI1
 x99JPhXPQu5l4nxi7r7gDiEev4jHHIzIUKiw6BmKRKSeFB34OEXSmtAn390dyMZjmUNc4GWsB
 i+UwYVzoK7FSewS56BgoO7Lx1JlvIfEcYeOyjWkjKdi+hUjan5i9+DSSFZQRzzNnMQ8aFyzk0
 U9EGONEeVG93OSvwzgYfchl8KOjtG4Vi6KNwz0likiMmytFurVoc2DkNoesaJ/fqlvH4dqDao
 jv/XAAAUtOwlJsqRlN2SS0yEgExyqCCCvi0vMClb1RZr778fkrh5mL+MDtJkYpiQHIhE177dP
 svkJb24cEPskJMjhcNwXPYfORbC8V5h+34oGt+wAusHXRKSNOVmeRXT9pY3ynHot8AxrPcvUp
 QE72HO7FVfAPvGsiSVgWrEIi9aXg2UdvPHNT//jhCHUVDZ0FMlBSkryN57SvCaa9dfOT+iMbm
 NFF1MK3YMRMmoclNZ
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

>> I find this commit message improvable also according to Linux software
>> development documentation.
>
> Causing people to send out new versions of things for tweaks to the
> commit log consumes time for them and everyone they're sending changes t=
o.

Improving patches (besides source code adjustments) is an usual software
development activity, isn't it?


> Pushing people to make trivial rewordings of their commit logs to
> match your particular taste is not a good use of people's time.

Corresponding tweaks can be combined with recommended tags.
It can be that only =93trivial=94 items were left over for another bit
of fine-tuning. Subsequent description variants can reduce
the probability for additional patch review iterations, can't they?

Regards,
Markus
