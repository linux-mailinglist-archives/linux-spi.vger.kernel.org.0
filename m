Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B36D154D59
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2020 21:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgBFUqf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Feb 2020 15:46:35 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41780 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbgBFUqe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 Feb 2020 15:46:34 -0500
Received: by mail-pg1-f193.google.com with SMTP id l3so3338806pgi.8;
        Thu, 06 Feb 2020 12:46:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ydXcMt/LQYTtC9+Pd4G5bVOYifXyo4gCLRUMdz5nmlc=;
        b=izxZTnUEAW22RfqU1j51xkVaz4f4OhJha8Ap9BYyUUG54PWehpIlBQx4rzx46DJTPn
         Em5fAElIFaTKZKysamF99ePfoXd7w+lbKDbuPF7Pj/c6SOhOkj+y4I4MTe6p8zQdiClg
         HmNxu9xkEeFcmtKkThjVM3oJKAjLnm8jPyG7qD8HTVxxHKZZjEgk7UkKRd2XKeFWcbLy
         73B4cBSOI91QI3EqXGUnhAaiUFzz8HxDuBybhy6x6MaebOcQh+f4WxE0LNRJOTE1OFiJ
         TKlkOMsUGhzRdyLqvqnZSmgHOTl/GxyCcKr0wecnYjQVe0ZRAlUdhzbnE1kk77yLKo5J
         od9w==
X-Gm-Message-State: APjAAAX5JJKjJRqN8qT76kZhWxk85QA1MaCbEsIFvrGzEO+sd+hGfNeF
        AMUEHAyI10v/5y6YFBAbQg==
X-Google-Smtp-Source: APXvYqydDGv//MOaVcF+ltoSavNLLJxMyuRh6BXzPCHtlqH+bv6Q9/MQz/jK+pB7hWgEMXve5dqvDw==
X-Received: by 2002:a62:2ad1:: with SMTP id q200mr6105224pfq.123.1581021991999;
        Thu, 06 Feb 2020 12:46:31 -0800 (PST)
Received: from rob-hp-laptop (63-158-47-182.dia.static.qwest.net. [63.158.47.182])
        by smtp.gmail.com with ESMTPSA id r13sm170817pjp.14.2020.02.06.12.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 12:46:31 -0800 (PST)
Received: (nullmailer pid 13921 invoked by uid 1000);
        Thu, 06 Feb 2020 18:40:30 -0000
Date:   Thu, 6 Feb 2020 18:40:30 +0000
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-spi@vger.kernel.org, Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 4/5] dt-bindings: spi: spi-nxp-fspi: Add support for
 imx8mm, imx8qxp
Message-ID: <20200206184030.GA11381@bogus>
References: <20200202125950.1825013-1-aford173@gmail.com>
 <20200202125950.1825013-4-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200202125950.1825013-4-aford173@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Feb 02, 2020 at 06:59:49AM -0600, Adam Ford wrote:
> Add support for nxp,imx8qxp-fspi and nxp,imx8mm-fspi do the bindings

s/do/to/

> document.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V2: No change
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> index 2cd67eb727d4..7ac60d9fe357 100644
> --- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> @@ -2,6 +2,9 @@
>  
>  Required properties:
>    - compatible : Should be "nxp,lx2160a-fspi"
> +			    "nxp,imx8qxp-fspi"
> +			    "nxp,imx8mm-fspi"

All 3 are different and no compatibility?

> +
>    - reg :        First contains the register location and length,
>                   Second contains the memory mapping address and length
>    - reg-names :  Should contain the resource reg names:
> -- 
> 2.24.0
> 
