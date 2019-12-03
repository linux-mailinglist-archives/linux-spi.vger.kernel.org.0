Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49A3A10FA86
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2019 10:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbfLCJOk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Dec 2019 04:14:40 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36053 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfLCJOk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Dec 2019 04:14:40 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so2929452ljg.3
        for <linux-spi@vger.kernel.org>; Tue, 03 Dec 2019 01:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ibxFTL99nZfGHgHM7+x1YjdXfnhpJpkrDP8f+skOgIA=;
        b=D1iAE8q/KGABGizwZDSHslb0vJSyb6mfOsgUOU5f9eHBmQSg5VVoVDk9qzDiWjm8TH
         ZbfkV2/Tzb8krPdKRy5GQAVGUumDG3MjbWYZM/hYSi1v+ggIW+qKRsoQO9h39BC+bKf4
         7q+YxrOcThwl2gCSYjJCR+EUXfTp7TaiUpj+VI8iYqlsLx/5aNqO0epOS1i1LrXKtymc
         4zKD5FPduu0rIc/O24Q3VOqetgh6qwnGhPopGhLk5EFT4O2ksJBzqnVV4lphKs9uIkio
         1IWqEwxC9TC9oKF5QMsYq5bTHdeeTpMaDluyq2YbC6+531DD1K0YpyamEpe1VZ/8aDUr
         6O3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ibxFTL99nZfGHgHM7+x1YjdXfnhpJpkrDP8f+skOgIA=;
        b=L0y7y4fapoXh+BltALeV9hcCN917Be/1mICvwLrcm2coffpN+etSjjouz9neku0hVC
         HBUhoryrsmV85d4N7DtoYXRjAvXX1OtraIu4E7bJ3Tfx0fDcG2/fhn28XU8idx9Xpu5h
         UPdDUkBzHIEt0rw4/99Ix8rN/9pp3KRm6Dd0NLqoFMQGsPrKiv22krRBeBXmC4BRhe28
         ZV3S8T/SABBuv54EoQOE6DxdX0cIDDVwAsEdb6Iq2mUfI2RuCoWMpTi8Pok6eC1+QywM
         UhVWaQRfYH9hnltpikP1PsWgsZuqntVxxk06txG3LzJhq8ELQaz44Z+RoopJuk4gv/dh
         Z/DQ==
X-Gm-Message-State: APjAAAV3nE0hrZlx9RTRXLO0JuukdEoyBnQ7TYjp8IQlxoeMSRZvhv6C
        x0p7tBM3icDfmLsA3I25MhKiaA==
X-Google-Smtp-Source: APXvYqwEJaOurJTgEbZzE6L+uZ+yr4/MMM2YE/gfBOM2AublB9oN8kuUTft3TfQtUehuFY2JI3Psgg==
X-Received: by 2002:a2e:864f:: with SMTP id i15mr1841990ljj.29.1575364478041;
        Tue, 03 Dec 2019 01:14:38 -0800 (PST)
Received: from ?IPv6:2a00:1fa0:603:a130:f42a:4975:5c69:31d3? ([2a00:1fa0:603:a130:f42a:4975:5c69:31d3])
        by smtp.gmail.com with ESMTPSA id y21sm975720ljm.25.2019.12.03.01.14.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 01:14:37 -0800 (PST)
Subject: Re: [PATCH 6/6] dt-bindings: spi: Document Renesas SPIBSC bindings
To:     Chris Brandt <chris.brandt@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Mason Yang <masonccyang@mxic.com.tw>
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-7-chris.brandt@renesas.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <17e66541-41fb-26ed-c87b-15c59ab57bef@cogentembedded.com>
Date:   Tue, 3 Dec 2019 12:14:30 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191203034519.5640-7-chris.brandt@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello!

On 03.12.2019 6:45, Chris Brandt wrote:

> Document the bindings used by the Renesas SPI bus space controller.
> 
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> ---
>   .../bindings/spi/spi-renesas-spibsc.txt       | 48 +++++++++++++++++++
>   1 file changed, 48 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-spibsc.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-spibsc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-spibsc.txt
> new file mode 100644
> index 000000000000..b5f7081d2d1e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-spibsc.txt
> @@ -0,0 +1,48 @@
> +Renesas SPI Bus Space Controller (SPIBSC) Device Tree Bindings
> +
> +Otherwise referred to as the "SPI Multi I/O Bus Controller" in SoC hardware
> +manuals. This controller was designed specifically for accessing SPI flash
> +devices.
> +
> +Required properties:
> +- compatible: should be an SoC-specific compatible value, followed by
> +		"renesas,spibsc" as a fallback.
> +		supported SoC-specific values are:
> +		"renesas,r7s72100-spibsc"	(RZ/A1)
> +		"renesas,r7s9210-spibsc"	(RZ/A2)
> +- reg: should contain three register areas:
> +       first for the base address of SPIBSC registers,
> +       second for the direct mapping read mode

    That's only 2 areas, not 3. :-)

> +- clocks: should contain the clock phandle/specifier pair for the module clock.
> +- power-domains: should contain the power domain phandle/specifier pair.
> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +- flash: should be represented by a subnode of the SPIBSC node,
> +	 its "compatible" property contains "jedec,spi-nor" if SPI is used.

    Are any other flash variants supported?

> +
> +Example:
> +
> +	spibsc: spi@1f800000 {
> +		compatible = "renesas,r7s9210-spibsc", "renesas,spibsc";
> +		reg = <0x1f800000 0x8c>, <0x20000000 0x10000000 >;
> +		clocks = <&cpg CPG_MOD 83>;
> +		power-domains = <&cpg>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		flash@0 {
> +			compatible = "jedec,spi-nor";
> +			reg = <0>;
> +			spi-max-frequency = <40000000>;
> +
> +			partitions {
> +				compatible = "fixed-partitions";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +
> +				partition@0000000 {
> +					label = "u-boot";
> +					reg = <0x00000000 0x80000>;
> +				};
> +			};
> +		};

MBR, Sergei
