Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E08495538
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jan 2022 21:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377556AbiATUGt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Jan 2022 15:06:49 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:37862 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377548AbiATUGs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Jan 2022 15:06:48 -0500
Received: by mail-ot1-f45.google.com with SMTP id i7-20020a9d68c7000000b0059396529af8so9021313oto.4;
        Thu, 20 Jan 2022 12:06:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LyXjarcAT6UiTZlSxq7lxukI8C5X8DTNYYmieun7qOo=;
        b=niH9cEIBLgz+YSeE4mWvyH1z2gKmQXOjoJPdgqxEJ4PZ++O0yz5GwBcmKUG5++KFo+
         hFXcEMnciqA7rDEfcUXE9/8tBFjVIScIKesItx7I+PITEb+5GkIW9si8LYCXDv8ZxHwq
         0P2BoA2S4bPaVdEBnrLohDfC+vUL+MhWryzhOuMPeeyqkwinChyoYZcWaYDX44pblOyC
         owXcr2ETcscvc0lVIMkQMC8jVG8ZtEtxGP8G3eN32aCf2MyI53FwpNavuiDjQRZIRkYE
         Wcg0MNx4g8qwx46cUpb0OZXMsBG/Ewiqk9hHbxcAOGife1mBRKNCPZ35MM8yLYUB5biU
         wN/Q==
X-Gm-Message-State: AOAM533zDUk/kwfvzHjXm4KjNQ9irmQGYvxanrgrgOTVf/gzqd1gYr54
        V/GK1xGOixoq7ctLLfeG3A==
X-Google-Smtp-Source: ABdhPJzYwX6+yULGoyMB5QB2aCp7quAHuNa0tI/8Lf4Zcr9g8tj+Os+bklYXt6lYNRUP0yqQyA0Ydg==
X-Received: by 2002:a05:6830:22f7:: with SMTP id t23mr299858otc.213.1642709207628;
        Thu, 20 Jan 2022 12:06:47 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o10sm121243oiw.6.2022.01.20.12.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 12:06:46 -0800 (PST)
Received: (nullmailer pid 1857252 invoked by uid 1000);
        Thu, 20 Jan 2022 20:06:45 -0000
Date:   Thu, 20 Jan 2022 14:06:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Antipov <daantipov@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Dmitry Antipov <dmanti@microsoft.com>
Subject: Re: [PATCH v3 3/5] Documentation: DT bindings for HID over SPI.
Message-ID: <YenA1ZxT0/ZHw+RH@robh.at.kernel.org>
References: <20220115023135.234667-1-dmanti@microsoft.com>
 <20220115023135.234667-4-dmanti@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220115023135.234667-4-dmanti@microsoft.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jan 14, 2022 at 06:31:33PM -0800, Dmitry Antipov wrote:
> From: Dmitry Antipov <dmanti@microsoft.com>
> 
> Added documentation describes the required properties for implementing
> Device Tree for a device supporting HID over SPI and also provides an
> example.

Bindings are in DT schema format now.

> 
> Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> ---
>  .../bindings/input/hid-over-spi.txt           | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100755 Documentation/devicetree/bindings/input/hid-over-spi.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/hid-over-spi.txt b/Documentation/devicetree/bindings/input/hid-over-spi.txt
> new file mode 100755
> index 000000000000..5eba95b5724e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/hid-over-spi.txt
> @@ -0,0 +1,43 @@
> +* HID over SPI Device-Tree bindings
> +
> +HID over SPI provides support for Human Interface Devices over the SPI bus. HID
> +Over SPI Protocol Specification 1.0 was written by Microsoft and is available at
> +https://www.microsoft.com/en-us/download/details.aspx?id=103325.
> +
> +If this binding is used, the kernel module spi-hid will handle the communication

What's a kernel module? ;) Bindings are OS independent (or supposed to 
be), so kernel details do not belong here.

> +with the device and the generic hid core layer will handle the protocol.
> +
> +Required properties:
> +- compatible: must be "hid-over-spi"

Bindings describe devices, not protocols. There is no such 
'hid-over-spi' device. Please see the existing hid-over-i2c binding. 
It's fine to have this compatible, but only as a fallback compatible.

> +- interrupts: interrupt line
> +- vdd-supply: phandle of the regulator that provides the supply voltage

What happens when the device has 2 supplies? And there's some timing 
requirement between them?

> +- reset_gpio-gpios: gpio wired to the device reset line

'reset-gpios' is the standard name.

> +- post-power-on-delay-ms: time required by the device after enabling its
> +regulators or powering it on, before it is ready for communication 
> +- minimal-reset-delay-ms: minimum amount of time that device needs to be in
> +reset state for the reset to take effect

These properties are what happens when we try to do generic bindings. 
It's a never-ending addition of more properties to try to describe 
(poorly) the power sequencing requirements.

> +- input-report-header-address: this property and the rest are described in HID
> +Over SPI Protocol Spec 1.0
> +- input-report-body-address
> +- output-report-address
> +- read-opcode
> +- write-opcode
> +- flags

A bit too generic. We generally want to avoid having a property name 
with 2 different types/meaning. It's not something we check for yet, but 
I plan to at some point.

> +
> +Example:
> +	spi-hid-dev0 {
> +		compatible = "hid-over-spi";
> +		reg = <0>;
> +		interrupts-extended = <&tlmm 42 IRQ_TYPE_EDGE_FALLING>;
> +		vdd-supply = <&pm8350c_l3>;
> +		input-report-header-address = <0x1000>;
> +		input-report-body-address = <0x1004>;
> +		output-report-address = <0x2000>;
> +		read-opcode = <0x0b>;
> +		write-opcode = <0x02>;
> +		flags = <0x00>;
> +		reset_gpio-gpios = <&tlmm 25 GPIO_ACTIVE_LOW>;
> +		post-power-on-delay-ms = <5>;
> +		minimal-reset-delay-ms = <5>;
> +		
> +	};
> -- 
> 2.25.1
> 
> 
