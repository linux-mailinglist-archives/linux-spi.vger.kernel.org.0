Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDDC403A58
	for <lists+linux-spi@lfdr.de>; Wed,  8 Sep 2021 15:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhIHNKq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Sep 2021 09:10:46 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:29374 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230217AbhIHNKp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Sep 2021 09:10:45 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188ApafM008053;
        Wed, 8 Sep 2021 08:09:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=MZRmANVcnGIe7dgd2WWdbSlcg++fYXLrfzEBsoXKpHs=;
 b=QJ1eBnO/gxMcNsVrzN5wDorqllNmGBcaTXE4HC4uU6I0CdWrKpNwq0dgkmqQnFotu6wz
 zRD+3wxJQkEVgbEdGHmpKqMHjnzH3I85Ai3mWBI5h2d43yGR5THzMC65Y71RS6D2VHOH
 MO6PwTAC0xqgHRMwHAnhbpgmAOcDwaSICNT9qq2/Y2yNhr2dqzlL9Yac+XA8I9zC5ocW
 4AUS0F3yF5PY3N0f1Z3chJLZEbZ8DVIkslzUK131OFKJUWIJLs2l88pmu2AiSYzEQ+Jf
 unxBrfNb1wX9Qim84nXeb/A3jr5AJYMqxwLteRH/kr8s72quGcQfAWAx6gdQ5pvtOFWJ kw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3axcp99b2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 08 Sep 2021 08:09:32 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 8 Sep
 2021 14:09:30 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 8 Sep 2021 14:09:30 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4D5BDB16;
        Wed,  8 Sep 2021 13:09:29 +0000 (UTC)
Date:   Wed, 8 Sep 2021 13:09:29 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
CC:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH 02/10] regmap: spi: Check raw_[read|write] against max
 message size
Message-ID: <20210908130929.GP9223@ediswmail.ad.cirrus.com>
References: <20210908113450.788452-1-tanureal@opensource.cirrus.com>
 <20210908113450.788452-3-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210908113450.788452-3-tanureal@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 1P_zy0Bc135IfFMruba1EXdTpMrC8yiT
X-Proofpoint-ORIG-GUID: 1P_zy0Bc135IfFMruba1EXdTpMrC8yiT
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Sep 08, 2021 at 12:34:43PM +0100, Lucas Tanure wrote:
> regmap-spi will split data and address between two transfers
> in the same message, so max_[read|write] must include space
> for the address and padding
> 
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> ---
>  drivers/base/regmap/regmap-spi.c |  4 ++++
>  drivers/base/regmap/regmap.c     | 15 +++++++++++++++
>  include/linux/regmap.h           |  3 +++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/drivers/base/regmap/regmap-spi.c b/drivers/base/regmap/regmap-spi.c
> index 0e6552e57ecf..1434c502e340 100644
> --- a/drivers/base/regmap/regmap-spi.c
> +++ b/drivers/base/regmap/regmap-spi.c
> @@ -123,6 +123,10 @@ static const struct regmap_bus *regmap_get_spi_bus(struct spi_device *spi,
>  		bus->free_on_exit = true;
>  		bus->max_raw_read = max_size;
>  		bus->max_raw_write = max_size;
> +
> +		if (spi_max_message_size(spi) != SIZE_MAX)
> +			bus->max_combined_rw = spi_max_message_size(spi);

I am not sure max_combined_rw is the best name here, it makes
sense in a SPI context where reads are a write followed by a
read. But does it really make sense for all buses? Like an MMIO
this no longer seems a very meaningful name.

Perhaps max_transaction? But I am often not the best at thinking
of names myself.

> +
>  		return bus;
>  	}
>  
> diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
> index fe3e38dd5324..1cd936e097b0 100644
> --- a/drivers/base/regmap/regmap.c
> +++ b/drivers/base/regmap/regmap.c
> @@ -718,6 +718,7 @@ struct regmap *__regmap_init(struct device *dev,
>  	struct regmap *map;
>  	int ret = -EINVAL;
>  	enum regmap_endian reg_endian, val_endian;
> +	size_t reg_pad_size;
>  	int i, j;
>  
>  	if (!config)
> @@ -815,6 +816,20 @@ struct regmap *__regmap_init(struct device *dev,
>  	if (bus) {
>  		map->max_raw_read = bus->max_raw_read;
>  		map->max_raw_write = bus->max_raw_write;
> +		if (bus->max_combined_rw) {
> +			reg_pad_size = map->format.reg_bytes + map->format.pad_bytes;

Maybe reg_overhead_size or something? This line uses pad to both
mean the actual padding in pad_bytes and to mean address +
padding in reg_pad_size.

Thanks,
Charles
