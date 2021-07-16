Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6E03CBDEF
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jul 2021 22:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbhGPUrq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jul 2021 16:47:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26513 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234129AbhGPUrp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Jul 2021 16:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626468289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2hOSl7T8uaeeFLE5+UEIkT2Ky1iFxWg4XaCDh/v6oAM=;
        b=ewDQBrMt3ig4NWmEIa1ViMiivyQ59UnbyIfDVQQe/FDNm+njmbbNOBi3UMF4zS2FVXgoB+
        QeGKv9m/TFZAoDJ52IO28WFCrY+GiMTI3bMLqAIZedUCVf9cmVL9hhxnFwK3ftleGjh+Ym
        KQJNe+LM/eXW/NKkQy2DzO3LQ7Dgk6U=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-ExYtnYoiOK2k4u4tb1Axwg-1; Fri, 16 Jul 2021 16:44:48 -0400
X-MC-Unique: ExYtnYoiOK2k4u4tb1Axwg-1
Received: by mail-qv1-f69.google.com with SMTP id d17-20020a0cfe910000b02902e01fc8ee77so7486369qvs.21
        for <linux-spi@vger.kernel.org>; Fri, 16 Jul 2021 13:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2hOSl7T8uaeeFLE5+UEIkT2Ky1iFxWg4XaCDh/v6oAM=;
        b=ssVDCprTmo4on3gBOYeR+GzR/pGCnUPm1a8iAN6+tXZ3qah1+1+P8ZVMSTk0Eh/3t8
         dTatECbXzXbRP136kC50AXQIebRl3RWmRDN3xr1tuFBfv3aU6BNxub54OQqLMBmjlWBH
         MNquqB2FSrfzJYNF+vpwRfmVFHVcJ28QrRVreLT4xCNKhB6ExjUZL5K9Q6eI2h2c/hu4
         q6EJLWT7XINy72EzJdcJ78Gh093coBxXGPFdvGN6hvY0sTiDLRvIm6X/uRYUkAxMX20j
         lNIHQdpONijUe9kVUNNuNXNj7kQyGdV/hQRIFFJDiIICbDIhbCFCYGqMZHBwbniKid6K
         d91w==
X-Gm-Message-State: AOAM532oXhcZkNvV+gaG+0ntPeDyqgJ2dse1L9Vphjz5tFDhTeI0FSNm
        ObaWdoag0FlV0BfTTaHWgfwP1LB45fKW0rqbX0VeCqbZKNLE3ZofE3ZQNlvku7kLHSXX6ec4Wud
        +z2qrm6c+iefJyRlHQzYs4ScHnobyC79ZetKiaIqBHA8yXdM/HjOoKTiDODLOHO8bL+M=
X-Received: by 2002:a0c:cdc6:: with SMTP id a6mr12055716qvn.15.1626468288421;
        Fri, 16 Jul 2021 13:44:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySk4FYXysPvZ8XbnmBZ1swg1qoJWhXD2QzxodwEZF9W9BDb8u8S6hPtBgK6GGEILviRId/pg==
X-Received: by 2002:a0c:cdc6:: with SMTP id a6mr12055691qvn.15.1626468288230;
        Fri, 16 Jul 2021 13:44:48 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a19sm3479074qtb.54.2021.07.16.13.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 13:44:47 -0700 (PDT)
Subject: Re: [PATCH v5 2/3] spi: spi-altera-dfl: support n5010 feature
 revision
To:     =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>,
        Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
References: <20210716135441.3235863-1-martin@geanix.com>
 <20210716135441.3235863-3-martin@geanix.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <be04e83e-bdf7-3a5c-ff34-a7cbf91f6ba2@redhat.com>
Date:   Fri, 16 Jul 2021 13:44:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210716135441.3235863-3-martin@geanix.com>
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
> The Max10 BMC on the Silicom n5010 PAC is slightly different than the
> existing BMCs, so use a dedicated feature revision detect it.
>
> Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
> Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
>
> Changes since v4:
>   * Moved spi board_info structure from global/static scope
>     to function/stack scope
>
> Changes since v3:
>   * Changed "BMC's" to "BMCs"
>   * Added Moritz' Reviewed-by
>
> Changes since v2:
>   * None
>
> Changes since v1:
>   * use feature revision from struct dfl_device instead of reading it
>     from io-mem
>
>   drivers/spi/spi-altera-dfl.c | 21 ++++++++++++---------
>   1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/spi/spi-altera-dfl.c b/drivers/spi/spi-altera-dfl.c
> index 39a3e1a032e0..44fc9ee13fc7 100644
> --- a/drivers/spi/spi-altera-dfl.c
> +++ b/drivers/spi/spi-altera-dfl.c
> @@ -104,13 +104,6 @@ static const struct regmap_config indirect_regbus_cfg = {
>   	.reg_read = indirect_bus_reg_read,
>   };
>   
> -static struct spi_board_info m10_bmc_info = {
> -	.modalias = "m10-d5005",
> -	.max_speed_hz = 12500000,
> -	.bus_num = 0,
> -	.chip_select = 0,
> -};
> -
>   static void config_spi_master(void __iomem *base, struct spi_master *master)
>   {
>   	u64 v;
> @@ -130,6 +123,7 @@ static void config_spi_master(void __iomem *base, struct spi_master *master)
>   
>   static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
>   {
> +	struct spi_board_info board_info = { 0 };
>   	struct device *dev = &dfl_dev->dev;
>   	struct spi_master *master;
>   	struct altera_spi *hw;
> @@ -170,9 +164,18 @@ static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
>   		goto exit;
>   	}
>   
> -	if (!spi_new_device(master,  &m10_bmc_info)) {
> +	if (dfl_dev->revision == FME_FEATURE_REV_MAX10_SPI_N5010)
> +		strscpy(board_info.modalias, "m10-n5010", SPI_NAME_SIZE);
> +	else
> +		strscpy(board_info.modalias, "m10-d5005", SPI_NAME_SIZE);
> +
> +	board_info.max_speed_hz = 12500000;
> +	board_info.bus_num = 0;
> +	board_info.chip_select = 0;
> +
> +	if (!spi_new_device(master, &board_info)) {
>   		dev_err(dev, "%s failed to create SPI device: %s\n",
> -			__func__, m10_bmc_info.modalias);
> +			__func__, board_info.modalias);
>   	}
>   

Looks good to me.

Reviewed-by: Tom Rix <trix@redhat.com>

>   	return 0;

