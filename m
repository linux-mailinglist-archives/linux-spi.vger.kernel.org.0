Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A5E331EF5
	for <lists+linux-spi@lfdr.de>; Tue,  9 Mar 2021 07:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhCIGGu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Mar 2021 01:06:50 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:56094 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhCIGG1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 Mar 2021 01:06:27 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4Dvl8K1N5jz1qs49;
        Tue,  9 Mar 2021 07:06:25 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4Dvl8K0H5Nz1qqkj;
        Tue,  9 Mar 2021 07:06:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id z7RsuVO_N5Bt; Tue,  9 Mar 2021 07:06:22 +0100 (CET)
X-Auth-Info: EqBJ4vaOt1kmSNyU5jbSBDc1dVSIvvbVLPsrRxBaEhg=
Received: from [192.168.1.107] (92-52-238-184.pool.digikabel.hu [92.52.238.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue,  9 Mar 2021 07:06:22 +0100 (CET)
Reply-To: hs@denx.de
Subject: Re: [EXT] [PATCH v2 2/4] dt-bindings: spi: add compatible entry for
 imx8mp in FlexSPI controller
To:     Kuldeep Singh <kuldeep.singh@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
References: <20210309053116.1486347-1-hs@denx.de>
 <20210309053116.1486347-3-hs@denx.de>
 <DB6PR0402MB275838BF727B891FD6E2A62AE0929@DB6PR0402MB2758.eurprd04.prod.outlook.com>
From:   Heiko Schocher <hs@denx.de>
Message-ID: <290d37d7-7362-e00d-0e19-5fb5b78a4bf2@denx.de>
Date:   Tue, 9 Mar 2021 07:06:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <DB6PR0402MB275838BF727B891FD6E2A62AE0929@DB6PR0402MB2758.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi!

On 09.03.21 06:56, Kuldeep Singh wrote:
> Hi Heiko,
> 
>> -----Original Message-----
>> From: Heiko Schocher <hs@denx.de>
>> Sent: Tuesday, March 9, 2021 11:01 AM
>> To: linux-arm-kernel@lists.infradead.org
>> Cc: Heiko Schocher <hs@denx.de>; Ashish Kumar <ashish.kumar@nxp.com>;
>> Mark Brown <broonie@kernel.org>; Rob Herring <robh+dt@kernel.org>; Yogesh
>> Gaur <yogeshgaur.83@gmail.com>; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org; linux-spi@vger.kernel.org
>> Subject: [EXT] [PATCH v2 2/4] dt-bindings: spi: add compatible entry for imx8mp in
>> FlexSPI controller
>>
>> Caution: EXT Email
>>
>> add compatible entry "nxp,imx8mp-fspi" in NXP FlexSPI controller
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> ---
>>
>> (no changes since v1)
>>
>>  Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
>> b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
>> index 7ac60d9fe3571..fd5f081f6d91b 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
>> +++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
>> @@ -4,6 +4,7 @@ Required properties:
>>    - compatible : Should be "nxp,lx2160a-fspi"
>>                             "nxp,imx8qxp-fspi"
>>                             "nxp,imx8mm-fspi"
>> +                           "nxp,imx8mp-fspi"
> 
> It seems the changes are not on top of tree. Please see[1] for latest changes including imx8dxl entry.
> Snippet below:
> 
> Required properties:
>   - compatible : Should be "nxp,lx2160a-fspi"
> 			    "nxp,imx8qxp-fspi"
> 			    "nxp,imx8mm-fspi"
> 			    "nxp,imx8dxl-fspi"

My patches are based on mainline..
*   144c79ef33536 - (origin/master, origin/HEAD) Merge tag 'perf-tools-fixes-for-v5.12-2020-03-07'
of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux (vor 32 Stunden) <Linus Torvalds>

Should I post this patch rebased on [1] or may all patches
rebased on [1] ?

Thanks!

bye,
Heiko
> 
> Thanks
> Kuldeep
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/tree/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> 

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
