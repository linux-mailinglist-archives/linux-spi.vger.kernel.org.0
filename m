Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3FED3CBDFF
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jul 2021 22:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbhGPUtw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jul 2021 16:49:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28083 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233227AbhGPUtw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Jul 2021 16:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626468416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y//emM5RtevFVuv02pvQEtLcPSNBoyUazVRqH8qhJrg=;
        b=JIGPzBStEUzIsIAT7q+65zdNEzZQRL10MHn+SMKp4mQcR6PGC1lJwqSB53xH6RE91bptRh
        zs44b8BTQ7TdzbttKGd+hnPDYwGO6gpcA7oA/QxTqBF24GHRme6kuqSgLAsjzaB+IPNsEg
        kVqXUqzE0bKCYQf7o7tuKXucE1/0/X4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-8wdhQ_g8PLOrx8KSqB-QzQ-1; Fri, 16 Jul 2021 16:46:55 -0400
X-MC-Unique: 8wdhQ_g8PLOrx8KSqB-QzQ-1
Received: by mail-qv1-f69.google.com with SMTP id bk10-20020a05621406eab02902d1aac9c421so7551755qvb.1
        for <linux-spi@vger.kernel.org>; Fri, 16 Jul 2021 13:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Y//emM5RtevFVuv02pvQEtLcPSNBoyUazVRqH8qhJrg=;
        b=NrDPDIs6lVGhAzDNEwKFzA3BeophhIGwtlXXoFdMaWhrFQ6hy9nAQ5YRuoAnyFioX+
         i+XtUnzA99NwH53/o8OMIbDGrzgvsBJN4ObP36a/k8MzezFyXZXM1O7d4rcqeocX5LMC
         n25oh0XFTK6JDKsvKJMfvOhr2iUqabOzMIh1WBm1m4+ore47WXmeDqUIl0Hwkwh10eQ4
         j4hsxajqu4F8Hthq4Q501wCR1vpbnwaGUV70GVEfXa22RCUkX8grP2TUm1N/HMigOrx+
         MaWOsfhQta+OycPy8fiAxtLi9oujSNHJeg8waZiwG1PgT4SrcvuoDU7LGr7ZbRMqVyUb
         Tuqw==
X-Gm-Message-State: AOAM533h0G9qxlb/BiKf5JE/y9V0FQC4WkyhfoAMWYgLYGiY7UKq+qfZ
        wESQLEqGA+zyoWZZtLKE/wXavfW1ryI9E9d/nMMRamCTDmo8bSNSXoAyQ1VNLZzLbP/RNJX3OvY
        +hcRgocjASzz6G82nVUHo
X-Received: by 2002:a37:411:: with SMTP id 17mr11848155qke.225.1626468415472;
        Fri, 16 Jul 2021 13:46:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwaeuIafGpIFBrSp6F2jqOQPtMysFqiFmqK2xpgV89hJlVXNri8ZgeOTcNwPS7r3jsl2qkvw==
X-Received: by 2002:a37:411:: with SMTP id 17mr11848137qke.225.1626468415270;
        Fri, 16 Jul 2021 13:46:55 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k6sm3609100qtg.78.2021.07.16.13.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 13:46:54 -0700 (PDT)
Subject: Re: [PATCH v5 1/3] fpga: dfl: expose feature revision from struct
 dfl_device
To:     =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>,
        Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
References: <20210716135441.3235863-1-martin@geanix.com>
 <20210716135441.3235863-2-martin@geanix.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <ec0f22f3-c7e5-baaf-c60c-77ecc4cb9e86@redhat.com>
Date:   Fri, 16 Jul 2021 13:46:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210716135441.3235863-2-martin@geanix.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 7/16/21 6:54 AM, Martin Hundebøll wrote:
> From: Martin Hundebøll <mhu@silicom.dk>
>
> DFL device drivers have a common need for checking feature revision
> information from the DFL header, as well as other common DFL information
> like the already exposed feature id and type.
>
> This patch exposes the feature revision information directly via the DFL
> device data structure.
>
> Since the DFL core code has already read the DFL header, this this patch
> saves additional mmio reads from DFL device drivers too.
>
> Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
> Acked-by: Wu Hao <hao.wu@intel.com>
> Acked-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
>
> Changes since v4:
>   * Renamed 'rev' to 'revision' as per Tom's suggestion
>
> Changes since v3:
>   * Added Hao's Acked-by
>   * Added Matthew's Acked-by
>
> Changes since v2:
>   * Reworded commit message as per Hao's suggestion
>
> Changes since v1:
>   * This patch replaces the previous patch 2 and exposes the feature
>     revision through struct dfl_device instead of a helper reading from
>     io-mem
>
>   drivers/fpga/dfl.c  | 27 +++++++++++++++++----------
>   drivers/fpga/dfl.h  |  1 +
>   include/linux/dfl.h |  1 +
>   3 files changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 511b20ff35a3..e73a70053906 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -381,6 +381,7 @@ dfl_dev_add(struct dfl_feature_platform_data *pdata,
>   
>   	ddev->type = feature_dev_id_type(pdev);
>   	ddev->feature_id = feature->id;
> +	ddev->revision = feature->revision;
>   	ddev->cdev = pdata->dfl_cdev;
>   
>   	/* add mmio resource */
> @@ -717,6 +718,7 @@ struct build_feature_devs_info {
>    */
>   struct dfl_feature_info {
>   	u16 fid;
> +	u8 revision;
>   	struct resource mmio_res;
>   	void __iomem *ioaddr;
>   	struct list_head node;
> @@ -796,6 +798,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
>   		/* save resource information for each feature */
>   		feature->dev = fdev;
>   		feature->id = finfo->fid;
> +		feature->revision = finfo->revision;
>   
>   		/*
>   		 * the FIU header feature has some fundamental functions (sriov
> @@ -910,19 +913,17 @@ static void build_info_free(struct build_feature_devs_info *binfo)
>   	devm_kfree(binfo->dev, binfo);
>   }
>   
> -static inline u32 feature_size(void __iomem *start)
> +static inline u32 feature_size(u64 value)
>   {
> -	u64 v = readq(start + DFH);
> -	u32 ofst = FIELD_GET(DFH_NEXT_HDR_OFST, v);
> +	u32 ofst = FIELD_GET(DFH_NEXT_HDR_OFST, value);
>   	/* workaround for private features with invalid size, use 4K instead */
>   	return ofst ? ofst : 4096;
>   }
>   
> -static u16 feature_id(void __iomem *start)
> +static u16 feature_id(u64 value)
>   {
> -	u64 v = readq(start + DFH);
> -	u16 id = FIELD_GET(DFH_ID, v);
> -	u8 type = FIELD_GET(DFH_TYPE, v);
> +	u16 id = FIELD_GET(DFH_ID, value);
> +	u8 type = FIELD_GET(DFH_TYPE, value);
>   
>   	if (type == DFH_TYPE_FIU)
>   		return FEATURE_ID_FIU_HEADER;
> @@ -1021,10 +1022,15 @@ create_feature_instance(struct build_feature_devs_info *binfo,
>   	unsigned int irq_base, nr_irqs;
>   	struct dfl_feature_info *finfo;
>   	int ret;
> +	u8 revision;
> +	u64 v;
> +
> +	v = readq(binfo->ioaddr + ofst);
> +	revision = FIELD_GET(DFH_REVISION, v);
>   
>   	/* read feature size and id if inputs are invalid */
> -	size = size ? size : feature_size(binfo->ioaddr + ofst);
> -	fid = fid ? fid : feature_id(binfo->ioaddr + ofst);
> +	size = size ? size : feature_size(v);
> +	fid = fid ? fid : feature_id(v);
>   
>   	if (binfo->len - ofst < size)
>   		return -EINVAL;
> @@ -1038,6 +1044,7 @@ create_feature_instance(struct build_feature_devs_info *binfo,
>   		return -ENOMEM;
>   
>   	finfo->fid = fid;
> +	finfo->revision = revision;
>   	finfo->mmio_res.start = binfo->start + ofst;
>   	finfo->mmio_res.end = finfo->mmio_res.start + size - 1;
>   	finfo->mmio_res.flags = IORESOURCE_MEM;
> @@ -1166,7 +1173,7 @@ static int parse_feature_private(struct build_feature_devs_info *binfo,
>   {
>   	if (!is_feature_dev_detected(binfo)) {
>   		dev_err(binfo->dev, "the private feature 0x%x does not belong to any AFU.\n",
> -			feature_id(binfo->ioaddr + ofst));
> +			feature_id(readq(binfo->ioaddr + ofst)));
>   		return -EINVAL;
>   	}
>   
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 2b82c96ba56c..422157cfd742 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -243,6 +243,7 @@ struct dfl_feature_irq_ctx {
>   struct dfl_feature {
>   	struct platform_device *dev;
>   	u16 id;
> +	u8 revision;
>   	int resource_index;
>   	void __iomem *ioaddr;
>   	struct dfl_feature_irq_ctx *irq_ctx;
> diff --git a/include/linux/dfl.h b/include/linux/dfl.h
> index 6cc10982351a..431636a0dc78 100644
> --- a/include/linux/dfl.h
> +++ b/include/linux/dfl.h
> @@ -38,6 +38,7 @@ struct dfl_device {
>   	int id;
>   	u16 type;
>   	u16 feature_id;
> +	u8 revision;
>   	struct resource mmio_res;
>   	int *irqs;
>   	unsigned int num_irqs;

Looks good to me.

Reviewed-by: Tom Rix <trix@redhat.com>

