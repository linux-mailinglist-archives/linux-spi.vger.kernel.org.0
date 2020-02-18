Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9631B161F7A
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2020 04:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgBRDTZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Feb 2020 22:19:25 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34485 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgBRDTZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Feb 2020 22:19:25 -0500
Received: by mail-pf1-f194.google.com with SMTP id i6so9921617pfc.1
        for <linux-spi@vger.kernel.org>; Mon, 17 Feb 2020 19:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BjESBNNd4zA4/xXm+Fx/7whm6bU5Bz00evekQd0atG0=;
        b=dPNOklRfcHZVXvg7ClWdTf50p7mBZKJAOS/1kBxt364yg0SJ9NR2pVzUhYQuie/Vhb
         mMRua+uI+pbN+WPIdh+Sp/JKzbQwQLrs9Jtmznr471cIt8KfuuFsaGh2Gy2t0OS/5MI9
         GmmZaMoaQ6ayO1vMiuBacWdRTEHEfEsjEktWphi9e+nTd8RtfLmsxK3SN1sQg+eHMq/D
         bx4wl0/OdxKOkFPybOPCCuqlMZJQCovzuLYDT5vsmpJbFgIfr53TcRdhQkTmunM9b088
         WJB9Sd0BOYjxO1iOl71fPb6cCIGNn0KD0MoMnnBDIvAbMnHa5BWc7ROU1gsbb92mq4Ar
         vzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BjESBNNd4zA4/xXm+Fx/7whm6bU5Bz00evekQd0atG0=;
        b=PJLRC4Bd9JluuUA/eRK9Jq04djnGiJI29ivn+4F06JqdqqfZ9g5D86sGTWnOpiBAZK
         QBQ1dmCl8bTZusqqJYuntr243iHFXRkKOlNxb19/YTTbHrjspBYZkX08fAIR7+LGcZPz
         lUWvPlRO4K0Ho9DSzxoncE5e6h1wgxJjFQzexQIxnwqnIw0mnaCKctlr6NeXT+iIwTLl
         y0paE1DNk9DHvhlwx3KRZJMZUf3gyX7zER4uVPXtWkRTD8/8u4I6I0fvGRcenf48ozap
         pckaY4iGy4D8FgUgnm7zd1hPwuwFyKALsW+73SPJTA+yYoyqribzY1PUweVS2ay3nAxE
         vzfQ==
X-Gm-Message-State: APjAAAW35KXXhBJF8O8lkYf4P25pMhahFhl02tNXLcn+8YnSJtDzYkxh
        80suCwkpKnNHat4osINObCm8mA==
X-Google-Smtp-Source: APXvYqxYWtCDEG+AexP7+FJdG6S5k/Ny4QSg9Cetbw2G9McmCV5S+hbhBPCqRdjRY+7F1vGcUuaOLA==
X-Received: by 2002:a63:8b44:: with SMTP id j65mr20230161pge.272.1581995964276;
        Mon, 17 Feb 2020 19:19:24 -0800 (PST)
Received: from ripper (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t28sm1773258pfq.122.2020.02.17.19.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 19:19:23 -0800 (PST)
Date:   Mon, 17 Feb 2020 19:18:30 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, agross@kernel.org, wsa@the-dreams.de,
        broonie@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, mka@chromium.org,
        dianders@chromium.org
Subject: Re: [PATCH 6/6] arm64: dts: sc7180: Add interconnect for QUP and QSPI
Message-ID: <20200218031830.GX955802@ripper>
References: <1581946205-27189-1-git-send-email-akashast@codeaurora.org>
 <1581946205-27189-7-git-send-email-akashast@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581946205-27189-7-git-send-email-akashast@codeaurora.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon 17 Feb 05:30 PST 2020, Akash Asthana wrote:

> Add interconnect ports for GENI QUPs and QSPI to set bus capabilities.
> 
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> ---
> Note:
>  - This patch depends on series https://patchwork.kernel.org/cover/11313817/
>    [Add SC7180 interconnect provider driver]. It won't compile without that.
> 
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 199 +++++++++++++++++++++++++++++++++++
>  1 file changed, 199 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index cc5a94f..04569c9 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -352,6 +352,14 @@
>  				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> +				interconnects = <&qup_virt MASTER_QUP_CORE_0
> +						&qup_virt SLAVE_QUP_CORE_0>,
> +						<&gem_noc MASTER_APPSS_PROC
> +						&config_noc SLAVE_QUP_0>,
> +						<&aggre1_noc MASTER_QUP_0
> +						&mc_virt SLAVE_EBI1>;

Please ignore the 80-char "limit" and write this as:
				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
						<&gem_noc ...>,
						<&aggre1_noc ...>;

Regards,
Bjorn
