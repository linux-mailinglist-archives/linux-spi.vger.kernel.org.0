Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8F5A1156D8
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2019 18:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfLFR5g (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Dec 2019 12:57:36 -0500
Received: from muru.com ([72.249.23.125]:44258 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbfLFR5g (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 6 Dec 2019 12:57:36 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5BB4B8047;
        Fri,  6 Dec 2019 17:58:13 +0000 (UTC)
Date:   Fri, 6 Dec 2019 09:57:31 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Jean Pihet <jean.pihet@newoldbits.com>
Cc:     Mark Brown <broonie@kernel.org>, Tero Kristo <t-kristo@ti.com>,
        linux-omap@vger.kernel.org, linux-spi@vger.kernel.org,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>,
        Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 1/3] TI QSPI: Fix fclk frequency
Message-ID: <20191206175731.GG35479@atomide.com>
References: <20191206160007.331801-1-jean.pihet@newoldbits.com>
 <20191206160007.331801-2-jean.pihet@newoldbits.com>
 <20191206162431.GF35479@atomide.com>
 <CAORVsuUBseM3vnZsSajMmUS1O6rEC4U_aa951HwMsGxyEm+t+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAORVsuUBseM3vnZsSajMmUS1O6rEC4U_aa951HwMsGxyEm+t+g@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

* Jean Pihet <jean.pihet@newoldbits.com> [191206 16:30]:
> Hi Tony,
> 
> On Fri, Dec 6, 2019 at 5:24 PM Tony Lindgren <tony@atomide.com> wrote:
> >
> > Hi Jean,
> >
> > * Jean Pihet <jean.pihet@newoldbits.com> [191206 16:01]:
> > > The QSPI IP is clocked by two clocks:
> > > - CORE_CLKOUTM4 / 2 (L3) as interface clock,
> > > - PER_CLKOUTM2 / 4 (L4) as functional clock, which is PER_CLKOUTM2
> > >   divided by 4, so at 192Mhz / 4 = 48MHz.
> > >
> > > Fix the use of the correct fclk by the driver and fix the frequency
> > > value so that the divider is correctly programmed to generate the
> > > desired frequency of QSPI_CLK.
> >
> > This source clock can be different between the SoC models, the
> > related fck probably needs to be fixed in the SoC specific dtsi
> > file.
> >
> > Currently qspi it's there only in dra7.dtsi, sounds like you
> > are using it on am3/am4 based on the clock name?
> 
> I am using the AM4376 chipset. Only the interface is fixed in the
> hwmod data as fck.
> What is the best solution to add the extra fck?

Well the long term solution would be to make it probe with
ti-sysc interconnect target module driver, then you can specify
both fck and ick there as needed.

Care to test with the patch below (without your changes) to see if
something else is still needed?

I only added the fck there, not sure if we should also the l3 ick.
Eventually this node will be a child of the l3 interconnect, and
genpd will ensure the l3 ick is in use when pm_runtime_get() is
done in the qspi driver.

Note that this will produce a boot time warning until the related
hwmod data is dropped. I'll be posting a proper patch once we
know what's going on here, not sure what's the right fix for the
clock issue for v5.5-rc series though.

Regards,

Tony

8< ----------------------
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -302,17 +302,33 @@
 			status = "disabled";
 		};
 
-		qspi: spi@47900000 {
-			compatible = "ti,am4372-qspi";
-			reg = <0x47900000 0x100>,
-			      <0x30000000 0x4000000>;
-			reg-names = "qspi_base", "qspi_mmap";
+		target-module@47900000 {
+			compatible = "ti,sysc-omap4", "ti,sysc";
+			//ti,hwmods = "qspi";
+			reg = <0x47900000 0x4>,
+			      <0x47900010 0x4>;
+			reg-names = "rev", "sysc";
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>,
+					<SYSC_IDLE_SMART_WKUP>;
+			clocks = <&l3s_clkctrl AM4_L3S_QSPI_CLKCTRL 0>;
+			clock-names = "fck";
 			#address-cells = <1>;
-			#size-cells = <0>;
-			ti,hwmods = "qspi";
-			interrupts = <0 138 0x4>;
-			num-cs = <4>;
-			status = "disabled";
+			#size-cells = <1>;
+			ranges = <0x0 0x47900000 0x1000>,
+				 <0x30000000 0x30000000 0x4000000>;
+
+			qspi: spi@0 {
+				compatible = "ti,am4372-qspi";
+				reg = <0 0x100>,
+				      <0x30000000 0x4000000>;
+				reg-names = "qspi_base", "qspi_mmap";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <0 138 0x4>;
+				num-cs = <4>;
+			};
 		};
 
 		dss: dss@4832a000 {
-- 
2.24.0
