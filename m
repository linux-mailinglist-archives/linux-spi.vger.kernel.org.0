Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2B68118E78
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2019 18:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfLJRDe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Dec 2019 12:03:34 -0500
Received: from muru.com ([72.249.23.125]:44646 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727568AbfLJRDd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 10 Dec 2019 12:03:33 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0AF2980E1;
        Tue, 10 Dec 2019 17:04:10 +0000 (UTC)
Date:   Tue, 10 Dec 2019 09:03:29 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Jean Pihet <jean.pihet@newoldbits.com>
Cc:     Tero Kristo <t-kristo@ti.com>, Mark Brown <broonie@kernel.org>,
        linux-omap@vger.kernel.org, linux-spi@vger.kernel.org,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>,
        Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 1/3] TI QSPI: Fix fclk frequency
Message-ID: <20191210170329.GM35479@atomide.com>
References: <20191206160007.331801-1-jean.pihet@newoldbits.com>
 <20191206160007.331801-2-jean.pihet@newoldbits.com>
 <20191206162431.GF35479@atomide.com>
 <CAORVsuUBseM3vnZsSajMmUS1O6rEC4U_aa951HwMsGxyEm+t+g@mail.gmail.com>
 <20191206175731.GG35479@atomide.com>
 <CAORVsuXe7SyAmzLv4VoKMsf4jcYV1bKoCixhsgZ3U0rBHFJA4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAORVsuXe7SyAmzLv4VoKMsf4jcYV1bKoCixhsgZ3U0rBHFJA4Q@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

* Jean Pihet <jean.pihet@newoldbits.com> [191210 16:24]:
> On Fri, Dec 6, 2019 at 6:57 PM Tony Lindgren <tony@atomide.com> wrote:
> > Care to test with the patch below (without your changes) to see if
> > something else is still needed?
> 
> With the patch applied fck still is the ick, not the L4 clock as required.

Hmm OK so I think we need fck at both the module level and qspi level.

> Could both ick and fck be defined in the DT files, like here below?
>    clocks = <&l3s_clkctrl AM4_L3S_QSPI_CLKCTRL 0>,
>                  <&l4per2_clkctrl AM4_L4PER2_QSPI_CLKCTRL 0>;
>    clock-names = "ick", "fck";
> The issue is that there is no l4_per for AM4.

Yes you can configure both fck and ick there, and also additional
clocks. But the clkctrl clock is the fck clock gate for this module,
and it's source can be the same as the interface clock for some
modules.

When I sent the experimental patch I confirmed that just the fck
as <&l3s_clkctrl AM4_L3S_QSPI_CLKCTRL 0>, ti-sysc.c driver can
read the qspi module revision register just fine. So that means
that it's enough for the module, and the spi_clk is another
clock specific to the child qspi IP in the module.

So based on that, I think we should set up the clocks in the
following way for the module and it's qspi child:

target-module@47900000 {
	...
	clocks = <&l3s_clkctrl AM4_L3S_QSPI_CLKCTRL 0>;
	clock-names = "fck";
	...

	qspi: spi@0 {
		...
		clocks = <&dpll_per_m2_div4_ck>;
		clock-names = "fck";
		...
	};
};

That way the qspi driver can set the divider on it's fck based
on "spi-max-frequency" dts property.

> Looking at the DRA7 DT files there is an fck defined (in dra7.dtsi):
>    clocks = <&l4per2_clkctrl DRA7_L4PER2_QSPI_CLKCTRL 25>;
>    clock-names = "fck";

Yeah so that's <&l3s_clkctrl AM4_L3S_QSPI_CLKCTRL 0> for
am437x.

> What is best to do from here?

Well can test again with the patch below to see if that is
enough to make it work :)

Regards,

Tony

8< -------------------
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -302,17 +302,35 @@ gpmc: gpmc@50000000 {
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
+				clocks = <&dpll_per_m2_div4_ck>;
+				clock-names = "fck";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <0 138 0x4>;
+				num-cs = <4>;
+			};
 		};
 
 		dss: dss@4832a000 {
-- 
2.24.0
