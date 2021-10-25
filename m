Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F45E43949B
	for <lists+linux-spi@lfdr.de>; Mon, 25 Oct 2021 13:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbhJYLRa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 Oct 2021 07:17:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230126AbhJYLR3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 25 Oct 2021 07:17:29 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1017C60238;
        Mon, 25 Oct 2021 11:15:07 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mexwW-001LU4-U6; Mon, 25 Oct 2021 12:15:04 +0100
MIME-Version: 1.0
Date:   Mon, 25 Oct 2021 12:15:04 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>, Brad Larson <brad@pensando.io>
Cc:     linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/11] arm64: dts: Add Pensando Elba SoC support
In-Reply-To: <20211025091731.GA2001@C02TD0UTHF1T.local>
References: <20211025015156.33133-1-brad@pensando.io>
 <20211025015156.33133-12-brad@pensando.io>
 <20211025091731.GA2001@C02TD0UTHF1T.local>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <a20805de16e1196c2ed46dd949473c9a@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: mark.rutland@arm.com, brad@pensando.io, linux-arm-kernel@lists.infradead.org, arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com, broonie@kernel.org, fancer.lancer@gmail.com, adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net, linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2021-10-25 10:17, Mark Rutland wrote:
> Hi,
> 
> On Sun, Oct 24, 2021 at 06:51:56PM -0700, Brad Larson wrote:
>> Add Pensando common and Elba SoC specific device nodes
>> 
>> Signed-off-by: Brad Larson <brad@pensando.io>
> 
> [...]
> 
>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) |
>> +					IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) |
>> +					IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) |
>> +					IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) |
>> +					IRQ_TYPE_LEVEL_LOW)>;
>> +	};
> 
> The GIC_CPU_MASK_SIMPLE() stuff is meant for GICv2, but as below you
> have GICv3, where this is not valid, so this should go.
> 
> Also, beware that GIC_CPU_MASK_SIMPLE(1) means a single CPU, which
> doesn't mak sense for the 16 CPUs you have.
> 
>> +		gic: interrupt-controller@800000 {
>> +			compatible = "arm,gic-v3";
>> +			#interrupt-cells = <3>;
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges;
>> +			interrupt-controller;
>> +			reg = <0x0 0x800000 0x0 0x200000>,	/* GICD */
>> +			      <0x0 0xa00000 0x0 0x200000>;	/* GICR */

This is missing the GICv2 compat regions that the CPUs implement.

>> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +			gic_its: msi-controller@820000 {
>> +				compatible = "arm,gic-v3-its";
>> +				msi-controller;
>> +				#msi-cells = <1>;
>> +				reg = <0x0 0x820000 0x0 0x10000>;
>> +				socionext,synquacer-pre-its =
>> +							<0xc00000 0x1000000>;
>> +			};
>> +		};
> 
> Is there any shared lineage with Synquacer? The commit message didn't
> describe this quirk.

Funny, it looks like there is a sudden outburst of stupid copy/paste
among HW designers. TI did the exact same thing recently.

This totally negates all the advantages of having an ITS and makes
sure that you have all the overhead. Facepalm...

         M.
-- 
Jazz is not dead. It just smells funny...
