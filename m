Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883FA33CEA3
	for <lists+linux-spi@lfdr.de>; Tue, 16 Mar 2021 08:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhCPHbV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Mar 2021 03:31:21 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:56305 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbhCPHbT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Mar 2021 03:31:19 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4F04j10yYGz1qtQs;
        Tue, 16 Mar 2021 08:31:17 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4F04j073FSz1qqkg;
        Tue, 16 Mar 2021 08:31:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id A_fpO2d_cO2G; Tue, 16 Mar 2021 08:31:13 +0100 (CET)
X-Auth-Info: X9487WXIvzbJnP0JmYxES60RFfFxCxiPWvV8/AXoFcE=
Received: from [192.168.1.107] (82-131-155-123.pool.digikabel.hu [82.131.155.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 16 Mar 2021 08:31:13 +0100 (CET)
Reply-To: hs@denx.de
Subject: Re: [EXT] [PATCH 0/2] enable flexspi support on imx8mp
To:     Kuldeep Singh <kuldeep.singh@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210316050425.1758778-1-hs@denx.de>
 <DB6PR0402MB2758717E38C20E7BFEC5FED8E06B9@DB6PR0402MB2758.eurprd04.prod.outlook.com>
From:   Heiko Schocher <hs@denx.de>
Message-ID: <85bf7b05-ed88-cb99-a501-3be1d5f6a156@denx.de>
Date:   Tue, 16 Mar 2021 08:31:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <DB6PR0402MB2758717E38C20E7BFEC5FED8E06B9@DB6PR0402MB2758.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Kuldeep,

On 16.03.21 07:42, Kuldeep Singh wrote:
> Hi Heiko,
> 
>> -----Original Message-----
>> From: Heiko Schocher <hs@denx.de>
>> Sent: Tuesday, March 16, 2021 10:34 AM
>> To: linux-spi@vger.kernel.org
>> Cc: Heiko Schocher <hs@denx.de>; linux-arm-kernel@lists.infradead.org;
>> Ashish Kumar <ashish.kumar@nxp.com>; Kuldeep Singh
>> <kuldeep.singh@nxp.com>; Mark Brown <broonie@kernel.org>; Rob Herring
>> <robh+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Yogesh Gaur
>> <yogeshgaur.83@gmail.com>; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: [EXT] [PATCH 0/2] enable flexspi support on imx8mp
>>
>> Caution: EXT Email
>>
>> add compatible entry in nxp_fspi driver for imx8mp
>>
>> new in v3:
>> seperate spi changes from series:
>> https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.inf
>> radead.org%2Fpipermail%2Flinux-arm-kernel%2F2021-
>> March%2F643289.html&amp;data=04%7C01%7Ckuldeep.singh%40nxp.com%
>> 7C5da0c3da3dbe410baaf508d8e83903f4%7C686ea1d3bc2b4c6fa92cd99c5c3
>> 01635%7C0%7C0%7C637514678868305498%7CUnknown%7CTWFpbGZsb3d8
>> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
>> D%7C1000&amp;sdata=2uy0EKUh4Nt0BceSQbIkCZDfakid3wx5uwebw0DhEIQ
>> %3D&amp;reserved=0
>>
>> into own series as Kuldeep suggested and rebased against
>> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
>> 144c79ef33536 ("Merge tag 'perf-tools-fixes-for-v5.12-2020-03-07' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux")
> 
> The changes are not on on top of spi tree
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> and therefore may not apply seamlessly.
> 
> I recently added driver support for imx8dxl which is accepted in spi tree
> And these patches will cause conflict with it.
> 
> Kindly rebase these patches on top of the tree.

Sorry, my fault. I thought the patches go into for-next ... 3 days
old ...

Ah, I had the wrong base ... I used "144c79ef33536" but it should
be "a43e89624baea"

Sorry and thanks for detecting!

I sent a new version soon...

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
