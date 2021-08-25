Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214F53F7B48
	for <lists+linux-spi@lfdr.de>; Wed, 25 Aug 2021 19:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbhHYRNx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Aug 2021 13:13:53 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:2116 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229540AbhHYRNx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Aug 2021 13:13:53 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17P9iXw3031375;
        Wed, 25 Aug 2021 12:13:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=llkaasdAN1hOhFdw2pARFyPRCn0QPaBxbtHFpjeUiPw=;
 b=gqQg93O1f4Iw7nlEQyVs9SYtzrbr+gro/7f1AFvLAtBUvHkhgI/VUV364D1DxwxG/Wsy
 ryQEbKFf3v0kNtxXMRdzR/TIIEe28+EURU7jGuBZqVeeIaiekxDBigGaEV0WFOvYQehb
 dGnxjIUOqj9efikf4LYJszh96GGcwPN/w71xu7jB3zyqHYHPS0+A66zvCOYMolEwPk54
 yTJoJ/0FZxWrOs2j9nsfmTTRKyIlLVqBKpYWjgF5RifU8iHP83tTiZAhvKQvb75aT+fD
 2n0acSSwIZtpen7V7+BENNRsBKQubqqgaJqay1nRdnEqOI2M1uFVqebYiYaXiMlk3uTI dA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3ankg98knh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 25 Aug 2021 12:13:03 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 25 Aug
 2021 18:13:01 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 25 Aug 2021 18:13:01 +0100
Received: from [198.61.65.58] (unknown [198.61.65.58])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7849B2BA;
        Wed, 25 Aug 2021 17:13:01 +0000 (UTC)
Subject: Re: [PATCH 3/9] regmap: spi: SPI_CONTROLLER_CS_PER_TRANSFER affects
 max read/write
To:     Mark Brown <broonie@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20210824104041.708945-1-tanureal@opensource.cirrus.com>
 <20210824104041.708945-4-tanureal@opensource.cirrus.com>
 <20210824163721.GF4393@sirena.org.uk>
From:   Lucas tanure <tanureal@opensource.cirrus.com>
Message-ID: <4c604d13-f177-ff75-d21f-27613e1b763f@opensource.cirrus.com>
Date:   Wed, 25 Aug 2021 18:13:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210824163721.GF4393@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: nJe50VVKS_yd58r8vr9qjluG_Q2aoqNE
X-Proofpoint-ORIG-GUID: nJe50VVKS_yd58r8vr9qjluG_Q2aoqNE
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 8/24/21 5:37 PM, Mark Brown wrote:
> On Tue, Aug 24, 2021 at 11:40:35AM +0100, Lucas Tanure wrote:
>> regmap-spi will split data and address between two transfers in the
>> same message so use addr_affects_max_raw_rw to flag that the number
>> bytes to read or write should be a little less (address + padding size),
>> so that the SPI controller can merge the entire message into a single
>> CS period
> 
> This should be handled by the SPI core, it's already relying on being
> able to do multiple transfers to handle message size limits and in any
> case this is a super standard thing to do so many clients would require
> special code.  The core should transparently coalesce things where it
> can, or error out if it can't, like it currently does when splitting
> transfers up.
> 
__spi_validate seems a good candidate, but I don't think spi have enough
information to merge two transfers into a single one.

For a message with N transfers how can spi core decide what to merge or 
what not merge. If mergers everything and is less than max_transfer_size 
success, but if bigger will need to stop merging and add an address in 
front of the next not merged transfer, but spi core is not aware of 
addresses
And in the case of multiple addresses and data transfers, how it will 
know doesn't need to be merged?

For me seems more reasonable for the regmap-spi stop splitting address
and data. Or at least if the controller has some flag change the bus for
one where it uses different functions for gather_write, async_write etc

Can you point which way you think the code should go? Investigate more 
spi core to coalesce transfers or change regmap-spi to not split address 
and data anymore?

Thanks
Lucas
