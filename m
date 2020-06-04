Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FA61EDBDF
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jun 2020 05:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgFDDrB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Jun 2020 23:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgFDDrA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 3 Jun 2020 23:47:00 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB29C03E96D;
        Wed,  3 Jun 2020 20:46:59 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p30so2901551pgl.11;
        Wed, 03 Jun 2020 20:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vIelIHMHC9bmcO62i5sJQbllpydzbql+AW2fKGKLm8w=;
        b=pwMJgwX+JwNqqrwv3Yn6+talwqvr3l+j3eiRhOeemebCxVbfw3/Jh3bCdkVn3S9hdn
         1P6mxCJuELmrmk11evGM07gHh65TJ4x2tmyyl76BWNjex+NwhQZa46uuLmUve1zFK90C
         EIPkQ6it+24y7HsxiI1wqw4f0MZB2eiKu8OtIU842VX/WEddK15W73xUT6hbuKHLRNPe
         pY/QAehksOROpPCGnKfZbSGSCrWO00/A66SjOS9mxab8610GtpHm+36wAzhCWPb8d+EN
         QqHHQ32YTZJMpRczVy5FctkD4D8lrooQpnVrrv/+ZbeHV3dVyzlj7p0VI7TiF4mqUg5/
         ouZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vIelIHMHC9bmcO62i5sJQbllpydzbql+AW2fKGKLm8w=;
        b=aWQIBWLUJ8dCj+rKLLtlvxKeGnjjsUO3Hbg9I3m7xR/ngI+I1Cp0vrW1AQBLkDkIcL
         lPi1ABa+YIR1J6uUNoEEdZr2EzswzvqqxMbQ1mSEr6/Hap6zIByrW1CAJXd2neP7ZC0C
         Fh6DGTVlKw4RYG/bUzUxjVRMIMOiXgm/FEbfZaVtZuZmbRT2bi6whd+rR+EDB7orxcUf
         Lnm5PryH+KbQUd+9U7musKUZyCamICIUZUKWUmtWXOpWRWEZy8UaF1+Ct5GUaiybMYv3
         t1ZPWFpD6E/4wBeiiFOatDVkrE7FRL6cY79kuaUxAsUp3TerfQoOr+Wt1In8ZpypFKI9
         8PIA==
X-Gm-Message-State: AOAM533xzm/k+x9XZ/Wer69RHPpYjsJYxpt2VILW+lwp2p2fUYargmdx
        U7uvG3MQYqtBIM1IOyMpLULrnOcv
X-Google-Smtp-Source: ABdhPJzAsFSdg/Xoho3piRcJExQi4MMZ1DyC2gHEk1MrkiQq2B109Fcf+SCBNd5L6CmKmGKTiwn5QQ==
X-Received: by 2002:a05:6a00:807:: with SMTP id m7mr2357570pfk.246.1591242418671;
        Wed, 03 Jun 2020 20:46:58 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p19sm3083367pff.116.2020.06.03.20.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 20:46:57 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE...),
        linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        Martin Sperl <kernel@martin.sperl.org>, lukas@wunner.de
Subject: [PATCH 0/3] spi: bcm2835: Enable shared interrupt support
Date:   Wed,  3 Jun 2020 20:46:52 -0700
Message-Id: <20200604034655.15930-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark, Lukas,

This patch series is implementing the approach that was discussed in
response to this previous submission:

https://lore.kernel.org/linux-arm-kernel/20200528185805.28991-1-nsaenzjulienne@suse.de/

It aims to have dedicated interrupt handlers for 2835 versus 2711/7211
so as to minimize the overhead for 2835.

Florian Fainelli (3):
  dt-bindings: spi: Document bcm2711 and bcm7211 SPI compatible
  ARM: dts: bcm2711: Update SPI nodes compatible strings
  spi: bcm2835: Enable shared interrupt support

 .../bindings/spi/brcm,bcm2835-spi.txt         |  3 +-
 arch/arm/boot/dts/bcm2711.dtsi                |  8 ++--
 drivers/spi/spi-bcm2835.c                     | 48 +++++++++++++++----
 3 files changed, 44 insertions(+), 15 deletions(-)

-- 
2.17.1

