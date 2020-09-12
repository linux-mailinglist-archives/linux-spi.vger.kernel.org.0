Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F419267CBB
	for <lists+linux-spi@lfdr.de>; Sun, 13 Sep 2020 00:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgILWxM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 12 Sep 2020 18:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgILWxJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 12 Sep 2020 18:53:09 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC83C061573
        for <linux-spi@vger.kernel.org>; Sat, 12 Sep 2020 15:53:07 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id n2so13513495oij.1
        for <linux-spi@vger.kernel.org>; Sat, 12 Sep 2020 15:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cz7l4bGKHxfOKLLWHxTc5xdJem1sy7MolpQaLjxPyvs=;
        b=IIBV5CQWWCEP4EhPOxuW3YsT6AjNbySc01Z76A7uG2S5Jzq2vxIBtlFKOh3c2PVluN
         6Q+8a8JxTNnLL1pAtN5w+bcInwxcSBKcxQ8oj/OLTJuJ33vqYS8ApCil3XyXgRaUx1Fy
         3WulOIghHJJWVtNcOFFrv3sc1o+anGkVrFXKMBrWA4mKKpnmItDpFOeY/KRjJ+T2tG5X
         8muMim8x7c1YuF8u/MszgIIoKoW7Ln1/A8F2CNBlD9xTHWPpRERb/CT5ipz8pMKoE0Ku
         2ORt0iLHrXk0JqyNfcIG9vc2ILu++sS0LkrerBC0v4i5k8QCCzGBV/Jqt1zeuDpaPZi8
         CpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cz7l4bGKHxfOKLLWHxTc5xdJem1sy7MolpQaLjxPyvs=;
        b=dVYWDFrLw0bQl+vZNtXzzhGf1AJJeLXEGxdvZK/WVX3PTl1IxI/HGVLWoSrCuAAJPA
         x41q+WTevC2r/k5c2qChiP+/x1F5OLvWZelqX6g0XiesFttVzbIDhHAMLV1LKo7ssaLz
         VfBZ903OvqPs4Qmy4Hf3JzX75ypxNNeUzVLc99uDxOMSvpjWn/vetIVSB5AaHNkI8yfz
         3ussFfftxG0aBbQxOEmzduLOWrl2hna25Bq4Hr/nKShu3t/FISC9Bh0mgBOBPAmMzUNK
         eQNVn1fpwO0Izxt8Nso+BDDdoi40BTBEyrCWU6aJqwIsABOSiPkO4ij6YZ+k4mjo3z1P
         EGnQ==
X-Gm-Message-State: AOAM5339kfT1gotMxEpouJPGzmi+2v1/KJG8s1XpxbBuudh8nkKA3BXl
        IscT6PbLKhPARgk//nZAfX4e+g==
X-Google-Smtp-Source: ABdhPJzz+WfOASs3fCTMejIUiZxcNkVCEBQZAPhC2t4wyDdxudf/q6ZNd/UCcJKeUAn8xAUTMyZuuw==
X-Received: by 2002:aca:c5cd:: with SMTP id v196mr5077895oif.63.1599951186236;
        Sat, 12 Sep 2020 15:53:06 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id l5sm1027934otj.40.2020.09.12.15.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 15:53:05 -0700 (PDT)
Date:   Sat, 12 Sep 2020 17:53:02 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Akash Asthana <akashast@codeaurora.org>, swboyd@chromium.org,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/3] spi: spi-geni-qcom: Use the FIFO even more
Message-ID: <20200912225302.GA3715@yoga>
References: <20200912140730.1.Ie67fa32009b94702d56232c064f1d89065ee8836@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200912140730.1.Ie67fa32009b94702d56232c064f1d89065ee8836@changeid>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat 12 Sep 16:07 CDT 2020, Douglas Anderson wrote:

> In commit 902481a78ee4 ("spi: spi-geni-qcom: Actually use our FIFO") I
> explained that the maximum size we could program the FIFO was
> "mas->tx_fifo_depth - 3" but that I chose "mas->tx_fifo_depth()"
> because I was worried about decreased bandwidth.
> 
> Since that time:
> * All the interconnect patches have landed, making things run at the
>   proper speed.
> * I've done more measurements.
> 
> This lets me confirm that there's really no downside of using the FIFO
> more.  Specifically I did "flashrom -p ec -r /tmp/foo.bin" on a
> Chromebook and averaged over several runs.

Wouldn't there be a downside in the form of setting the watermark that
close to the full FIFO we have less room for being late handling the
interrupt? Or is there some mechanism involved that will prevent
the FIFO from being overrun?

Regards,
Bjorn

> 
> Before: It took 6.66 seconds and 59669 interrupts fired.
> After:  It took 6.66 seconds and 47992 interrupts fired.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/spi/spi-geni-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 0dc3f4c55b0b..7f0bf0dec466 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -308,7 +308,7 @@ static int spi_geni_init(struct spi_geni_master *mas)
>  	 * Hardware programming guide suggests to configure
>  	 * RX FIFO RFR level to fifo_depth-2.
>  	 */
> -	geni_se_init(se, mas->tx_fifo_depth / 2, mas->tx_fifo_depth - 2);
> +	geni_se_init(se, mas->tx_fifo_depth - 3, mas->tx_fifo_depth - 2);
>  	/* Transmit an entire FIFO worth of data per IRQ */
>  	mas->tx_wm = 1;
>  	ver = geni_se_get_qup_hw_version(se);
> -- 
> 2.28.0.618.gf4bc123cb7-goog
> 
