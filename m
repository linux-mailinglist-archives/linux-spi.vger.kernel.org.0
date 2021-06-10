Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9473A323C
	for <lists+linux-spi@lfdr.de>; Thu, 10 Jun 2021 19:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbhFJRi5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Jun 2021 13:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhFJRi4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Jun 2021 13:38:56 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62337C061574;
        Thu, 10 Jun 2021 10:37:00 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id c13so2926442oib.13;
        Thu, 10 Jun 2021 10:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WxflIbs/48qSISC+lCpr67Z9h2+PanKTJGd2chvt3SQ=;
        b=sMYeb2dDv0woPkwS8dxtiJAZn5Nngn64wlnDijDEBm0grkbAohUHqruJBngyFaEUOj
         bPTOw0+aoZDeLZXHUK6VApZGwIGHAzaz6gIKdy1WdAEHtJCy85OVtJo52W3Nicji/7z5
         ZmLGGFZQZdrLupZ0UNPHHAafJAu5dFcIeQ95BuHviiUF6tkI4TT08A3aHQr9f5cldbt/
         L9oi88V6lYN3YkzqJYvFkBTYhl6h1yIxzznDU4SLRQPy2tOkQaZ0Xd/C7q0VvQVMOQw+
         RLSHp6tqNOhU0P7tWoypuHA5dwYkPV5umr7Hi1JWCYuZZMGseduU4YcQK5icTwln/Mac
         FMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WxflIbs/48qSISC+lCpr67Z9h2+PanKTJGd2chvt3SQ=;
        b=fVBgbfUTPjpaI2+SYAX67UABKdPfHLBlcsa9C+WTTL4VlQ6fz4VzlNAictz5PABG9+
         5ShKfNN8uba/NM/pb3y4gBoqc4RIRg/p1kM3YdgLKfVIc19voyMcHLiCyxgTmJLoFPpR
         SurC6F2v4U4fxH+X5MYJt66mxrx3381gwmrG3IMCiWaucXOZ89Tx/V8pKHUqpLQngagk
         ezGsFs0phy9ifivoO0tMuyJ47/0cotYKx7cUg8D7GVDR67k1nXJoK5V2VJOOrnG05LtD
         GMw6P++aaJMIqZtUJVd/XQ2dUkxzU4myiwzyZuX/f35qyZaSlOM3qTVL1a4gmTuXeWME
         OwjQ==
X-Gm-Message-State: AOAM531n5uGl3AtaVv/J12GXYTkktZNta0N+E5AIDLGXvOwbHwaxhj8e
        ZEq3YG4xH+DFoOkHKhwn/Ak=
X-Google-Smtp-Source: ABdhPJwjCV1uWMlJ9KROgTfw2tgpkPH+P0jRB8KvKDtnhToT/kREHqzL6vWNrdVj3p+6zowc5WIgTw==
X-Received: by 2002:a05:6808:14e:: with SMTP id h14mr7095904oie.151.1623346619783;
        Thu, 10 Jun 2021 10:36:59 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id s15sm686945oih.15.2021.06.10.10.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 10:36:59 -0700 (PDT)
Date:   Thu, 10 Jun 2021 12:36:57 -0500
From:   Chris Morgan <macroalpha82@gmail.com>
To:     Jon Lin <jon.lin@rock-chips.com>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, jbx6244@gmail.com, hjc@rock-chips.com,
        yifeng.zhao@rock-chips.com, sugar.zhang@rock-chips.com,
        linux-rockchip@lists.infradead.org, linux-mtd@lists.infradead.org,
        p.yadav@ti.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH v7 9/9] arm64: dts: rockchip: Enable SFC for Odroid Go
 Advance
Message-ID: <20210610173657.GA20228@wintermute.localdomain>
References: <20210609140412.16058-1-jon.lin@rock-chips.com>
 <20210609141348.19178-1-jon.lin@rock-chips.com>
 <20210609141348.19178-5-jon.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609141348.19178-5-jon.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jun 09, 2021 at 10:13:48PM +0800, Jon Lin wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> This enables the Rockchip Serial Flash Controller for the Odroid Go
> Advance. Note that while the attached SPI NOR flash and the controller
> both support quad read mode, only 2 of the required 4 pins are present.
> The rx and tx bus width is set to 2 for this reason.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
> ---
> 
> Changes in v7: None
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> Changes in v1: None
> 
>  .../boot/dts/rockchip/rk3326-odroid-go2.dts      | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
> index 49c97f76df77..f78e11dd8447 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
> @@ -484,6 +484,22 @@
>  	status = "okay";
>  };
>  
> +&sfc {
> +	pinctrl-0 = <&sfc_clk &sfc_cs0 &sfc_bus2>;
> +	pinctrl-names = "default";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <108000000>;
> +		spi-rx-bus-width = <2>;
> +		spi-tx-bus-width = <2>;

Note that I am still working with Jon Lin to research this, but it was
found in testing that if I set the tx bus width to 1 the problems I
encountered in earlier are resolved. At this time I do not know if it
is an issue with the driver for the flash controller, or if the NOR, or
board itself has some sort of errata which prevent dual tx from working
correctly. Note that as of right now the flash chip I am using (an
XTX XT25F128B) is not currently supported in mainline, so it's very
possible this is some sort of errata with the chip. It's also possible
that there is something with the board that is interferring with dual
mode TX.  When Jon comes back that he has tested dual mode on the SFC
with a different board/chip I will recommend that we change the tx
bus width here to a 1, and then once the XT25F128B gets mainlined we
can see if someone else has issues with dual tx mode so we can note
that as a problem with the chip. Or maybe there is something weird
with dual tx mode yet on the SFC driver/controller, I don't know yet.
I'm all too happy to work with a Rockchip engineer so things like
this can be determined before we hit mainline. :-)

The XTX25F128B driver is currently awaiting a decision on how to handle
continuation codes, as this chip ID should be using continuation codes,
but doesn't appear to return them when you query for manufacturer ID.
So I should also note in the commit here that the SFC will still be
unusable on the Odroid Go Advance until the XTX25F128B is also
mainlined.

Thank you.

> +	};
> +};
> +
>  &tsadc {
>  	status = "okay";
>  };
> -- 
> 2.17.1
> 
> 
> 
