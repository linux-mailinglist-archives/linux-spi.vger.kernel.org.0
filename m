Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB119453DA9
	for <lists+linux-spi@lfdr.de>; Wed, 17 Nov 2021 02:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhKQBY6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Nov 2021 20:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbhKQBYx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Nov 2021 20:24:53 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0360C06122F
        for <linux-spi@vger.kernel.org>; Tue, 16 Nov 2021 17:21:53 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id t5so3375367edd.0
        for <linux-spi@vger.kernel.org>; Tue, 16 Nov 2021 17:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M0DL4Z+z7lD4X8gzZ0br5lXdNaFuU3WYYnUldjpHc2U=;
        b=nwq+nix4pOQgFe2cQDcY0ONGPbpxJ8sYMy/yq7her6nK8IAaY2rNQ3/k8ehU7eMZuc
         BZHmd+0AWLJceWNi/O1CPHLx4uT4KZq0v5u8cRnw9uGsUiBzDqZk/ninenAMx52mId9J
         57cXo85nb5SzFi1ufwA9w5fSFx7vpsSJjFmrlhb72RHqgDuyFlDrnjLEBhBJ2sP7og5o
         pqa6mqzGcg6w0zAxvbBhNRYx7ySeq1E/LFCO1Sa4+OFj8Pk4f9D+nDkLsevVN2iwA/3w
         UgkZT03wrnhv4U1re89+eWg263xXyl874+2ECrp1/IaYe1NM2h0Aas1G2dM8F/HaRfY8
         vF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M0DL4Z+z7lD4X8gzZ0br5lXdNaFuU3WYYnUldjpHc2U=;
        b=Xrw8kLMBQTKnl4tRqzVTbTVEDPGrrcff/TLXX5dMJSSuh7NBesd3DlTs8pPjVI5d2I
         lngNdBswMl6x9itYAsaophIXWyVsvieAlwRLyuIGhLgSIx+d+sHRZqFemm8P9COKIXWc
         DmIMwaRNPzBVAUg8S34PMdS1tGTCwtUlbkWc84etyKWOcs003HKccjnMvXTA80Fnp9ih
         uBIyziwIdTTqeiwXdGUETNljvA4D2daf1ooyyIUSmxFiZ2bMWWYLGLgqSN8u1x+JHN2L
         yh20hmJKhhV7wfNvLxVhRkPIiuWBCf8/ubBh89EwraFWUhPhSXrGqKVpigf1O4s4/vru
         yK8w==
X-Gm-Message-State: AOAM530sGUzJl15rABHPne9xOav55QeC7Sq7a0NdNw7VWMRCnX7lGe8X
        1Y+eLLCouAviFDsVUThhQxnuC1KRe6VZ6JHa1x3SiA==
X-Google-Smtp-Source: ABdhPJz+Zpnh28paqLB4qDHLzR3XVq2bt0ht3aoYvckA16R5n/koE3WziQ9CnstPTiZ+BYY0ZXMPZLKJl704orREtZg=
X-Received: by 2002:a17:907:d89:: with SMTP id go9mr16600378ejc.330.1637112112433;
 Tue, 16 Nov 2021 17:21:52 -0800 (PST)
MIME-Version: 1.0
References: <20211025015156.33133-1-brad@pensando.io> <20211025015156.33133-4-brad@pensando.io>
 <YXhErvvSfKIBvHae@robh.at.kernel.org>
In-Reply-To: <YXhErvvSfKIBvHae@robh.at.kernel.org>
From:   Brad Larson <brad@pensando.io>
Date:   Tue, 16 Nov 2021 17:21:41 -0800
Message-ID: <CAK9rFnyk=gW_ZRZUci3byu=DNwdrmKBb30HQgxK0iWJuVVPbfQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] dt-bindings: mmc: Add Pensando Elba SoC binding
To:     Rob Herring <robh@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

On Tue, Oct 26, 2021 at 11:10 AM Rob Herring <robh@kernel.org> wrote:
>
> On Sun, Oct 24, 2021 at 06:51:48PM -0700, Brad Larson wrote:
> > Pensando Elba ARM 64-bit SoC is integrated with this IP and
> > explicitly controls byte-lane enables resulting in an additional
> > reg property resource.
> >
> > Signed-off-by: Brad Larson <brad@pensando.io>
> > ---
> >  .../devicetree/bindings/mmc/cdns,sdhci.yaml         | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > index af7442f73881..6c68b7b5abec 100644
> > --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > @@ -15,13 +15,16 @@ allOf:
> >
> >  properties:
> >    compatible:
> > -    items:
> > -      - enum:
> > -          - socionext,uniphier-sd4hc
> > -      - const: cdns,sd4hc
> > +    oneOf:
> > +      - items:
> > +        - enum:
> > +            - socionext,uniphier-sd4hc
> > +            - pensando,elba-emmc
> > +        - const: cdns,sd4hc
> >
> >    reg:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 2
>
> If there is more than 1, then you need to describe what each entry is.

The dtschema update and yamllint install shows the errors your bot
reported.  With the updated cdns,sdhci.yaml to add the description for
Elba's two reg items this is what I'm getting with in 5.16.0-rc1
(next-20211116):

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
index 4207fed62dfe..c01a7283c468 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -12,17 +12,44 @@ maintainers:

 allOf:
   - $ref: mmc-controller.yaml
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - socionext,uniphier-sd4hc
+    then:
+      properties:
+        reg:
+          maxItems: 1
+          items:
+            - description: SDHCI CDNS HRS registers
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - pensando,elba-emmc
+    then:
+      properties:
+        reg:
+          maxItems: 2
+          items:
+            - description: SDHCI CDNS HRS registers
+            - description: Byte lane control register

 properties:
   compatible:
-    items:
-      - enum:
-          - microchip,mpfs-sd4hc
-          - socionext,uniphier-sd4hc
-      - const: cdns,sd4hc
+    oneOf:
+      - items:
+          - enum:
+              - socionext,uniphier-sd4hc
+              - pensando,elba-emmc
+          - const: cdns,sd4hc

   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2

   interrupts:
     maxItems: 1

$ make DT_CHECKER_FLAGS=-m dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
...
  DTEX    Documentation/devicetree/bindings/mmc/cdns,sdhci.example.dts
  DTC     Documentation/devicetree/bindings/mmc/cdns,sdhci.example.dt.yaml
  CHECK   Documentation/devicetree/bindings/mmc/cdns,sdhci.example.dt.yaml

These errors are reported for unrelated files not on DT_SCHEMA_FILES

bindings/net/qcom,ipa.yaml: ignoring, error in schema: properties:
qcom,smem-state-names
bindings/iio/adc/st,stm32-dfsdm-adc.yaml: ignoring, error in schema:
patternProperties: ^filter@[0-9]+$: properties: st,adc-channel-names
bindings/interconnect/qcom,rpmh.yaml: ignoring, error in schema:
properties: qcom,bcm-voter-names

Thanks,
Brad
