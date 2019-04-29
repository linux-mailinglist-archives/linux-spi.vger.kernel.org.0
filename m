Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC0BEC1B
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2019 23:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbfD2Vhn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Apr 2019 17:37:43 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33861 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729370AbfD2Vhn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Apr 2019 17:37:43 -0400
Received: by mail-ot1-f68.google.com with SMTP id n15so4003163ota.1;
        Mon, 29 Apr 2019 14:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oRIzLTrSx8sr8Z69AM2UYd9a4FXBrnnXDJEnqjx6bRs=;
        b=J5mhtTpvKGEXHtJUtASn0KqGsmAoIZFMI0Pp7IZI8ZDewIujHrlgdVWTotOJVbYnRC
         qFEX4JNTw6uG8wt+LGRjmNs2+ItzICy6knmZAyRVuflwHq/WDGHVRvyYuL3JRhecThAL
         aZa4gjwhCZcobAaJ1bwHQV3esmQL8VXCLz8xpIYt03I4TR/tC48fxfgXoiSETu/4d0+d
         KtWSR3pHOqA3BnA4yy3U4P+NyKMVuf8Rkj3S4JihyMB4sWBfKgG9EPGPdqyFkXdSHJ69
         Vk72qp5xByzw4j91qeMM2NDwIlzZtHZEhQPWc8AwxybwsPdgHJb1xvFijhMxmH6Tq2uG
         9wLw==
X-Gm-Message-State: APjAAAWFaRbQTce+JS7vnZUsUhy++Xnp9JnbpiuBqiP5sQeXY+NpEc7g
        UA99LbpuZxA77YgZS8aWXw==
X-Google-Smtp-Source: APXvYqxeGATGcJAobyxm9pqykSGskpXvjmXcXQZgSiDA+KW4LYFL0/aUikQVn3uyjbcKZnNFg9l4ZQ==
X-Received: by 2002:a9d:6d84:: with SMTP id x4mr3812433otp.337.1556573862454;
        Mon, 29 Apr 2019 14:37:42 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w10sm14496733oiw.48.2019.04.29.14.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 14:37:41 -0700 (PDT)
Date:   Mon, 29 Apr 2019 16:37:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     broonie@kernel.org, mark.rutland@arm.com,
        Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: spi: Add spi-mux-gpio
Message-ID: <20190429213740.GA29098@bogus>
References: <20190412050213.17698-1-chris.packham@alliedtelesis.co.nz>
 <20190412050213.17698-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412050213.17698-2-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Apr 12, 2019 at 05:02:11PM +1200, Chris Packham wrote:
> Add binding documentation for spi-mux-gpio which is a slightly more
> complicated hardware implementation of using gpios to steer SPI chip
> selects.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  .../devicetree/bindings/spi/spi-mux-gpio.txt  | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-mux-gpio.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-mux-gpio.txt b/Documentation/devicetree/bindings/spi/spi-mux-gpio.txt
> new file mode 100644
> index 000000000000..a32f25321d37
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-mux-gpio.txt
> @@ -0,0 +1,45 @@
> +SPI bus gpio multiplexer
> +
> +The SPI bus gpio multiplexer can be used to implement more complicated access
> +logic than can be supported with the cs-gpios property of a SPI bus.
> +
> +In the example below we have a SoC with a single SPI CS that is gated by the
> +state of a gpio to select the desired SPI device.
> +
> +     +----------+  CS    +-----+ CS0  +----+
> +     |          |--------|     |------|    |
> +     |          |        | \ / |      +----+
> +     |   SoC    |        |  +  |
> +     |          |  GPIO  | / \ | CS1  +----+
> +     |          |--------|     |------|    |
> +     +----------+        +-----+      +----+
> +
> +Required properties:
> +- compatible	- must be "spi-mux-gpio"
> +- gpios		- gpios used to implement the multiplexing logic
> +- spi-parent-bus - parent spi bus to use
> +
> +Optional properties:
> +- spi-parent-cs - chip select on parent bus to use. Defaults to 0 if not
> +                  specified.
> +
> +Example for a multiplexer with a single gpio:
> +
> +	spi-mux {
> +		compatible = "spi-mux-gpio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		gpios = <&gpio0 1 0>;
> +		spi-parent-bus = <&spi0>;
> +		spi-parent-cs = <0>;

Why is this out of band? We can do something similar to I2C and use the 
mux-control binding:

spi {
	mux@0 {
		compatible = "spi-mux";
		reg "0"; 
		mux-controls = ...;

		spi-dev@0 {};
		spi-dev@1 {};
	};

	spi-dev@1 {};

};

Rob
