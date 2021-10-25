Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3416439226
	for <lists+linux-spi@lfdr.de>; Mon, 25 Oct 2021 11:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhJYJUG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 Oct 2021 05:20:06 -0400
Received: from foss.arm.com ([217.140.110.172]:43360 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230146AbhJYJUG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 25 Oct 2021 05:20:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B47C92F;
        Mon, 25 Oct 2021 02:17:43 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.75.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 654D63F70D;
        Mon, 25 Oct 2021 02:17:40 -0700 (PDT)
Date:   Mon, 25 Oct 2021 10:17:31 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Brad Larson <brad@pensando.io>
Cc:     linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/11] arm64: dts: Add Pensando Elba SoC support
Message-ID: <20211025091731.GA2001@C02TD0UTHF1T.local>
References: <20211025015156.33133-1-brad@pensando.io>
 <20211025015156.33133-12-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025015156.33133-12-brad@pensando.io>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Sun, Oct 24, 2021 at 06:51:56PM -0700, Brad Larson wrote:
> Add Pensando common and Elba SoC specific device nodes
> 
> Signed-off-by: Brad Larson <brad@pensando.io>

[...]

> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) |
> +					IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) |
> +					IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) |
> +					IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) |
> +					IRQ_TYPE_LEVEL_LOW)>;
> +	};

The GIC_CPU_MASK_SIMPLE() stuff is meant for GICv2, but as below you
have GICv3, where this is not valid, so this should go.

Also, beware that GIC_CPU_MASK_SIMPLE(1) means a single CPU, which
doesn't mak sense for the 16 CPUs you have.

> +		gic: interrupt-controller@800000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			interrupt-controller;
> +			reg = <0x0 0x800000 0x0 0x200000>,	/* GICD */
> +			      <0x0 0xa00000 0x0 0x200000>;	/* GICR */
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			gic_its: msi-controller@820000 {
> +				compatible = "arm,gic-v3-its";
> +				msi-controller;
> +				#msi-cells = <1>;
> +				reg = <0x0 0x820000 0x0 0x10000>;
> +				socionext,synquacer-pre-its =
> +							<0xc00000 0x1000000>;
> +			};
> +		};

Is there any shared lineage with Synquacer? The commit message didn't
describe this quirk.

Thanks,
Mark.
