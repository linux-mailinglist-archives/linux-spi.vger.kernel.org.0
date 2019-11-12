Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B86ACF8844
	for <lists+linux-spi@lfdr.de>; Tue, 12 Nov 2019 06:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfKLFyR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Nov 2019 00:54:17 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34584 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfKLFyR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Nov 2019 00:54:17 -0500
Received: by mail-pg1-f195.google.com with SMTP id z188so5180324pgb.1;
        Mon, 11 Nov 2019 21:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RNUXeUQ2he9yGQNHJeu0ueH2/ESMsrmnicZwkmOdB+k=;
        b=GW4XPSBudhcmTSVwBxMyFjzIWM2FsIKdPr6SSTaRlyet8RhDmQiIVYqEJpEFWFcLm7
         XX5WTaJ9h4fgkVFaWc38tpXJKJTFDlDqWgcXTDt+lalFs/CX4prBGpF0+c3DWxJRIi/e
         DKYd5yYKRsEglGBgERR5fyQMcvQdV6isFOzPcFT688PfOvQFMgLwtcFYzvcCHA4gBnR6
         aq+jmerRh6Ss3zjJ0l4iYW7F1lR+mydnIt6+K4t14CyaQVPqNuoxEhCGyvhPfhUPt92s
         Hl3GoX+x8TM6wjZZYzTjqCWDpa7t8Su77y/1r7GtT+DZSwEfxB791o+eBGcorwK7p9sK
         vppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RNUXeUQ2he9yGQNHJeu0ueH2/ESMsrmnicZwkmOdB+k=;
        b=QUovztiR3T4qa0PD1/kLNzY8E5kKnK1gShS5FAQ8ZhitOmvZV+AKn5xdLeOHCCbcp0
         siZDzdvdipfgj17gOFyBPnXPKNyE9qp7JACWSDmwAVjGpR9fVTbDqM2mxAnIzgfQR6Nv
         yYsiNWU81hvm5SXUvyujIQwJ7DpBSkUerw43hrMNIcg0RoYkU7tr0hGptBo92nI49Yp7
         urNMDWwzZU/sT2uiH7hnizz8qKpeDVPDp3/X1TDq+gWVsokoYT96rSJa+/bfTZWjyTg6
         CyxkT8kgi4lixn0bdgPCWjiFAQBOD8osz6JATZ9ssotJdgs3IkVfAWwWzg8BgVivMtF/
         P4Pg==
X-Gm-Message-State: APjAAAWVIZSIxxqXGvLIb02yUgcznA6ef4JVzuXV2ruTSWORBnvRDHBS
        PaJigaGHWamOaO3qT7Vr3lk=
X-Google-Smtp-Source: APXvYqzU0C+BWuw3Ec2o2cnt5pc8T768D2XbYVOUzZfj0x1BLbP3fOUEtaqf2ctwzdSnAJv40qXrvw==
X-Received: by 2002:a63:ff65:: with SMTP id s37mr32689085pgk.331.1573538056221;
        Mon, 11 Nov 2019 21:54:16 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id d139sm23160178pfd.162.2019.11.11.21.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 21:54:15 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 1/2] spi: dt-bindings: spi-controller: add wakeup-source and interrupts
Date:   Mon, 11 Nov 2019 21:54:10 -0800
Message-Id: <20191112055412.192675-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191112055412.192675-1-dmitry.torokhov@gmail.com>
References: <20191112055412.192675-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This change adds bindings for wakeup-source and
interrupts/interrupt-names properties that can be used to configure
device as wakeup source on the system.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

---

 .../bindings/spi/spi-controller.yaml          | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 732339275848c..4e31a4bf6851c 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -78,6 +78,29 @@ patternProperties:
         description:
           Chip select used by the device.
 
+      interrupts:
+        items:
+          - description: main interrupt (attention) line.
+          - description: dedicated wakeup interrupt.
+        minItems: 1 # The wakeup interrupt is optional.
+        description:
+          Specifies interrupt lines a device is connected to. Typically a
+          device is wired to a single interrupt line that is used as
+          "attention" signal and also to wake up system when device is
+          set up as wakeup source. However on some systems a dedicated
+          wakeup line might be used.
+
+      interrupt-names:
+        items:
+          - const: irq
+          - const: wakeup
+        minItems: 1
+
+      wakeup-source:
+        description:
+          Device is capable of waking up the system.
+        type: boolean
+
       spi-3wire:
         $ref: /schemas/types.yaml#/definitions/flag
         description:
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

