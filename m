Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8505D64B523
	for <lists+linux-spi@lfdr.de>; Tue, 13 Dec 2022 13:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbiLMM15 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Dec 2022 07:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbiLMM14 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Dec 2022 07:27:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3511DDC2
        for <linux-spi@vger.kernel.org>; Tue, 13 Dec 2022 04:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670934426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q3HIhNOWOlqyZAfVIJSyvE8UbxGSHbYQ4wflm8IvR0o=;
        b=V/KGUjEMRNMcLFhZNfoBuRMZhGBhZg+NHSS/a7ZBJA2pXi00rpJYXzi8famPiwYz9yw2Qx
        C7vk2SPg0IZAmF/fQPe9dndaKIfjf9vqF3a2ukM0giPdwZggSKwor8IUPyJ43nSNmhmkQz
        K0efm5qEKe9fbAM+zQWnDysTdw/Wru4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-223-v1SEpamWN2mX9zZvdDHHXw-1; Tue, 13 Dec 2022 07:27:04 -0500
X-MC-Unique: v1SEpamWN2mX9zZvdDHHXw-1
Received: by mail-qk1-f200.google.com with SMTP id bj4-20020a05620a190400b006fc7c5d454cso17559696qkb.14
        for <linux-spi@vger.kernel.org>; Tue, 13 Dec 2022 04:27:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3HIhNOWOlqyZAfVIJSyvE8UbxGSHbYQ4wflm8IvR0o=;
        b=CdwBY4pR0zN8y0Ua0i2vNdDSerNiDSW/ceDsphiZlZoOGFnj5zHCPWsrYX7QzFIcI6
         UZkrbSmBYINdyWG0t4C9ohHYUNiYZuyt0MF/6gjAOxJxSLsldsPcnjefkk9lefZs33OF
         xUoJjUpHjLNUxyODCbg+nzESGuDiCriO4dpyM6mhs9cldSyOxlleU+ynahJgzcEmDmul
         uO2TxhhCQpbyjcuyZoG2mPjXV8bdFacFbWpjmoB9h8mnf+2LvEcGW5jxgKCEM7F5kzNG
         PjQIdB5b+5ktOoh+yq7Lx4lJBIZQPmQDt6iYoA//F2aTHk1wqpcSufmU0UT7oKY1mRal
         05aA==
X-Gm-Message-State: ANoB5pndQoZS2vhethJ8IHnOSxLtptwbjeCSvNaVMWA6CoEFM2mV2Ylb
        1upbphYsmnxSmylH0A59AFsDG0umOvWyFH3vHYHF8VgCVX2qbqT6PfE9GSW2eepF7D0sdsCvgH8
        27ZeO3S2hDW29fB6MERyA
X-Received: by 2002:ac8:741a:0:b0:3a8:fdf:8ff8 with SMTP id p26-20020ac8741a000000b003a80fdf8ff8mr15934058qtq.36.1670934423569;
        Tue, 13 Dec 2022 04:27:03 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5+MstVDv+MVwOl3qYohtomZj+xhx442a30ITmyito1dcoQdgvNwGbqhscVMKBykL5Rk6Ee/Q==
X-Received: by 2002:ac8:741a:0:b0:3a8:fdf:8ff8 with SMTP id p26-20020ac8741a000000b003a80fdf8ff8mr15934030qtq.36.1670934423278;
        Tue, 13 Dec 2022 04:27:03 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id t14-20020ac865ce000000b003a6a7a20575sm7415774qto.73.2022.12.13.04.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 04:27:02 -0800 (PST)
Date:   Tue, 13 Dec 2022 07:27:01 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Shazad Hussain <quic_shazhuss@quicinc.com>,
        Mark Brown <broonie@kernel.org>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahalaney@redhat.com, echanude@redhat.com,
        linux-spi@vger.kernel.org,
        Javier Martinez Canillas <fmartine@redhat.com>
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sc8280xp: add missing spi nodes
Message-ID: <Y5hvlX35nr8xQKEd@x1>
References: <20221212182314.1902632-1-bmasney@redhat.com>
 <20221212182314.1902632-5-bmasney@redhat.com>
 <c1c7b1eb-08e7-2ba5-d89a-e0be8f76fd69@quicinc.com>
MIME-Version: 1.0
In-Reply-To: <c1c7b1eb-08e7-2ba5-d89a-e0be8f76fd69@quicinc.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

+ Mark Brown and linux-spi list

On Tue, Dec 13, 2022 at 12:46:18PM +0530, Shazad Hussain wrote:
> On 12/12/2022 11:53 PM, Brian Masney wrote:
> > Add the missing nodes for the spi buses that's present on this SoC.
> > 
> > This work was derived from various patches that Qualcomm delivered
> > to Red Hat in a downstream kernel.
> > 
> > Signed-off-by: Brian Masney <bmasney@redhat.com>
> > ---
> >   arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 384 +++++++++++++++++++++++++
> >   1 file changed, 384 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > index 392a1509f0be..b50db09feae2 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > @@ -829,6 +829,22 @@ qup2_i2c16: i2c@880000 {
> >   				status = "disabled";
> >   			};
> > +			qup2_spi16: spi@880000 {
> > +				compatible = "qcom,geni-spi";
> > +				reg = <0 0x00880000 0 0x4000>;
> > +				clocks = <&gcc GCC_QUPV3_WRAP2_S0_CLK>;
> > +				clock-names = "se";
> > +				interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
> > +				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
> > +				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
> > +				interconnect-names = "qup-core", "qup-config", "qup-memory";
> > +				spi-max-frequency = <50000000>;
> 
> This is device property not host and same applicable for all below spi
> nodes.
> Also FYI let's enable below SPI for Qdrive usecases once spidev compatible
> name is confirmed.
> SE9  0x00A84000
> SE22 0x00898000

I talked to Javier Martinez Canillas yesterday about the spidev driver
and I think I now have a better understanding of what we need to do.
Quick background for Mark. For this automotive program, Qualcomm will be
delivering to Red Hat and our customers parts of the media stack in
userspace. This will be closed source, proprietary code that parts of it
will need to interface with SPI.

We can't add a generic qcom,spidev compatible to the spidev driver since
this is just a software abstraction. Instead, each type of device will
need to have it's own compatible that uniquely describes the type of
device. So you might have a compatible like qcom,spi-video-codec. There
will need to be a DT binding added that describes the hardware. I suspect
that a SPI device can simply be added to trivial-devices.yaml. Once the
DT binding is accepted, the compatible can be added to the spidev.c
driver. If an in-kernel driver is written in the future, then the 
compatible can be moved from spidev to the new driver.

Mark: Is my understanding above correct? If so, will it be a problem to
get a compatible added to spidev.c if the corresponding userspace code is
closed source and proprietary?

Brian

