Return-Path: <linux-spi+bounces-88-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4751F7FD376
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 11:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 022852826EC
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 10:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20B2134C5;
	Wed, 29 Nov 2023 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgI0UJEy"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA808D6C;
	Wed, 29 Nov 2023 02:03:06 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-4644b1b7257so120436137.2;
        Wed, 29 Nov 2023 02:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701252186; x=1701856986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0NkQ2/KZticKUcAethtV75Vrkh/D13iFQcdW3PKfqEo=;
        b=PgI0UJEyNCzhpHZSNMionxkfw+w6W5zJ8pbxPRelwPrNavQBE0BdLUz0m0tiByLHEg
         OjyC34zp14jGLqZ3X60csaoUSXAnVuOpFNbBWIfkaA5N/RswwTkraXbS/rHuVKggNrkf
         jxo5qlHPR05vfen/qCnfqHwIY+WzjA1GmNSwd5peS4D17kAbUNcPM/2xgFZKcrm3am6c
         fi1IQ0Xp95qbnOwHhZ2RxsNdEV5DyImMyQqi2j310653Fqi3wXwVHPvMp8uR8o0Wtfra
         9CYGTFtoXwzFqiZDRQNfeo5Hk6u8RRSdK4si48TpiTVcWt1cj7tGRoLSqgH9pEMZeW6P
         Xybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701252186; x=1701856986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NkQ2/KZticKUcAethtV75Vrkh/D13iFQcdW3PKfqEo=;
        b=WK2zg7Wp9UCo3sk4L3EO8b1+xPX8YC2a5//KL+w2Ownj8t7Sdf34A+/1g3uD3RIQS+
         iM8Gb8ozOKQYyqPf17eECE6IYFSk3K6gkKUcMMVcr9W+EMlqo24rpnndqeA8h0MjdTgZ
         Vc0u7N4KEiiWVapYeNayW+mrHYOJhDsoLTqKcSDSE/MDEhV8T4A0aRxNab5wdkGOTFHE
         TMRqijz0AzQDSd4HjLn72z97nxO18CGDwOyOXXCc/bSUg6FqKviTG8G8rk8qqLFbwgyI
         6URTyAsfDsKykwRwyjR/Szb2C/PGB2zotZFyN+274mNuDJN24WRDxi3gQpE2o1aI2keb
         Nmxw==
X-Gm-Message-State: AOJu0YwUs4qQZt5fwysvmYH7SoiP+141B9uXGWEt0p1NdAStmZBLZEUo
	kRUylygF+kEGdTq9MFmjQ38=
X-Google-Smtp-Source: AGHT+IHxRg+hseQ9m+VDBMWpd29R6DnEZh0jR3dYtIRR4zK3JNSKqAJmz9rYeo9KxrCM9hqG8NLpRw==
X-Received: by 2002:a05:6102:4423:b0:464:4a3f:dc43 with SMTP id df35-20020a056102442300b004644a3fdc43mr980739vsb.24.1701252185458;
        Wed, 29 Nov 2023 02:03:05 -0800 (PST)
Received: from errol.ini.cmu.edu ([72.95.245.133])
        by smtp.gmail.com with ESMTPSA id n1-20020a0ce941000000b0067a2b91f969sm4052028qvo.117.2023.11.29.02.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 02:03:05 -0800 (PST)
Date: Wed, 29 Nov 2023 05:03:03 -0500
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
To: Andrew Davis <afd@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Joel Stanley <joel@jms.id.au>, Mark Brown <broonie@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, Lee Jones <lee@kernel.org>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH RFC 2/5] drivers/soc/litex: Use
 devm_register_restart_handler()
Message-ID: <ZWcMVyTCfmkjMQpU@errol.ini.cmu.edu>
References: <20231117161006.87734-1-afd@ti.com>
 <20231117161006.87734-3-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117161006.87734-3-afd@ti.com>
X-Clacks-Overhead: GNU Terry Pratchett

On Fri, Nov 17, 2023 at 10:10:03AM -0600, Andrew Davis wrote:
> Use device life-cycle managed register function to simplify probe error
> path and eliminate need for explicit remove function.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>

Reviewed-by: Gabriel Somlo <gsomlo@gmail.com>

Thanks much,
--Gabriel
> ---
>  drivers/soc/litex/litex_soc_ctrl.c | 23 +++++------------------
>  1 file changed, 5 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/soc/litex/litex_soc_ctrl.c b/drivers/soc/litex/litex_soc_ctrl.c
> index 10813299aa106..7a0096d93c73d 100644
> --- a/drivers/soc/litex/litex_soc_ctrl.c
> +++ b/drivers/soc/litex/litex_soc_ctrl.c
> @@ -69,14 +69,11 @@ static int litex_check_csr_access(void __iomem *reg_addr)
>  
>  struct litex_soc_ctrl_device {
>  	void __iomem *base;
> -	struct notifier_block reset_nb;
>  };
>  
> -static int litex_reset_handler(struct notifier_block *this, unsigned long mode,
> -			       void *cmd)
> +static int litex_reset_handler(struct sys_off_data *data)
>  {
> -	struct litex_soc_ctrl_device *soc_ctrl_dev =
> -		container_of(this, struct litex_soc_ctrl_device, reset_nb);
> +	struct litex_soc_ctrl_device *soc_ctrl_dev = data->cb_data;
>  
>  	litex_write32(soc_ctrl_dev->base + RESET_REG_OFF, RESET_REG_VALUE);
>  	return NOTIFY_DONE;
> @@ -107,11 +104,9 @@ static int litex_soc_ctrl_probe(struct platform_device *pdev)
>  	if (error)
>  		return error;
>  
> -	platform_set_drvdata(pdev, soc_ctrl_dev);
> -
> -	soc_ctrl_dev->reset_nb.notifier_call = litex_reset_handler;
> -	soc_ctrl_dev->reset_nb.priority = 128;
> -	error = register_restart_handler(&soc_ctrl_dev->reset_nb);
> +	error = devm_register_restart_handler(&pdev->dev,
> +					      litex_reset_handler,
> +					      soc_ctrl_dev);
>  	if (error) {
>  		dev_warn(&pdev->dev, "cannot register restart handler: %d\n",
>  			 error);
> @@ -120,20 +115,12 @@ static int litex_soc_ctrl_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static void litex_soc_ctrl_remove(struct platform_device *pdev)
> -{
> -	struct litex_soc_ctrl_device *soc_ctrl_dev = platform_get_drvdata(pdev);
> -
> -	unregister_restart_handler(&soc_ctrl_dev->reset_nb);
> -}
> -
>  static struct platform_driver litex_soc_ctrl_driver = {
>  	.driver = {
>  		.name = "litex-soc-controller",
>  		.of_match_table = of_match_ptr(litex_soc_ctrl_of_match)
>  	},
>  	.probe = litex_soc_ctrl_probe,
> -	.remove_new = litex_soc_ctrl_remove,
>  };
>  
>  module_platform_driver(litex_soc_ctrl_driver);
> -- 
> 2.39.2
> 

