Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D262948F471
	for <lists+linux-spi@lfdr.de>; Sat, 15 Jan 2022 03:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbiAOCbs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Jan 2022 21:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbiAOCbr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Jan 2022 21:31:47 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E25C061574;
        Fri, 14 Jan 2022 18:31:47 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id e8so1051070plh.8;
        Fri, 14 Jan 2022 18:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ETUn97gqjRapopFWBGYK6do8y384tZH0myTQJGddZQU=;
        b=LDx12P1s2qPxOVD1DYF8E520auBww4eBKV/oA5TNyIoCWDPrTiMmdvTrf4zmQ4YUaR
         Ku4yoAu0sNrddcdhRR7XiEq2AFUnuI8JXkHgVfzWMzaDVyxiKRrLw2u6BrItsmr1rtB3
         7Dse4AWzZQiVsxbodxDKxkL2bjy92R5uaKtwrcFSg/ItfVG8ZUJjL3MdxzZy2WhBz7yl
         smvd6PSTrIQOyZ4V2svWeEY9PknRJmisWH22rwK8ZLdNm5nE+BGEI4I6jsp1F+REBgSr
         i2/ff0UQUIcMcmLpeXCwu+J4kQ/eFIGTakJ0VPqfKiJhhCg5Jg7pu0C7QFYFC+SukEMz
         aACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ETUn97gqjRapopFWBGYK6do8y384tZH0myTQJGddZQU=;
        b=boNa7TFHh6ZEjE6FQinUi5I79WDh/yyLtOqNJ0JnNJkui16nOvWSpUSP+VJEbs2878
         2E7VKBJNk0daI6csoBhgFFeiggdDvkfxLeVW8BCmFlA+PO9dWUv3uyJLKibAHqOOHu75
         fGV1K6zGjrRRV3PvojzwU7oj9kjzBHhsO4WEJbnsntUWubtF4iQVdbFNnaH/dkklFjVj
         EMFKNV8Si79M85WfITlmdTwTFJEEn7UHCdrGCdlsrnGrZBFWE9CMdPJoBR2ysQWAJYQQ
         cXhBsiLu4cIINOWtco5zKNjERuqc2yAc2imn3DwIvqMAmMyqT4BVQMl+ntpCZfNzE/3K
         X6ng==
X-Gm-Message-State: AOAM531CgYoqsBt3zUNlQMghUkgumzf9XuXZdW26NFdbahVNXFw1bM0C
        GUaSAmFuw9whkX66gGhC/IM=
X-Google-Smtp-Source: ABdhPJxfE90pBwHY/PMBozJo2yMwL6hjwOMSIIBa2NHOrDM5IR46pX2/yc/uUb8gDIuHgKj3CokdGw==
X-Received: by 2002:a17:90a:b791:: with SMTP id m17mr13632582pjr.239.1642213907185;
        Fri, 14 Jan 2022 18:31:47 -0800 (PST)
Received: from thelio.corp.microsoft.com ([2001:4898:80e8:38:6d64:e944:7a7c:3d])
        by smtp.gmail.com with ESMTPSA id oo14sm6874500pjb.34.2022.01.14.18.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 18:31:46 -0800 (PST)
From:   Dmitry Antipov <daantipov@gmail.com>
X-Google-Original-From: Dmitry Antipov <dmanti@microsoft.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, Dmitry Antipov <dmanti@microsoft.com>
Subject: [PATCH v3 3/5] Documentation: DT bindings for HID over SPI.
Date:   Fri, 14 Jan 2022 18:31:33 -0800
Message-Id: <20220115023135.234667-4-dmanti@microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220115023135.234667-1-dmanti@microsoft.com>
References: <20220115023135.234667-1-dmanti@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Dmitry Antipov <dmanti@microsoft.com>

Added documentation describes the required properties for implementing
Device Tree for a device supporting HID over SPI and also provides an
example.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
---
 .../bindings/input/hid-over-spi.txt           | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100755 Documentation/devicetree/bindings/input/hid-over-spi.txt

diff --git a/Documentation/devicetree/bindings/input/hid-over-spi.txt b/Doc=
umentation/devicetree/bindings/input/hid-over-spi.txt
new file mode 100755
index 000000000000..5eba95b5724e
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/hid-over-spi.txt
@@ -0,0 +1,43 @@
+* HID over SPI Device-Tree bindings=0D
+=0D
+HID over SPI provides support for Human Interface Devices over the SPI bus=
. HID=0D
+Over SPI Protocol Specification 1.0 was written by Microsoft and is availa=
ble at=0D
+https://www.microsoft.com/en-us/download/details.aspx?id=3D103325.=0D
+=0D
+If this binding is used, the kernel module spi-hid will handle the communi=
cation=0D
+with the device and the generic hid core layer will handle the protocol.=0D
+=0D
+Required properties:=0D
+- compatible: must be "hid-over-spi"=0D
+- interrupts: interrupt line=0D
+- vdd-supply: phandle of the regulator that provides the supply voltage=0D
+- reset_gpio-gpios: gpio wired to the device reset line=0D
+- post-power-on-delay-ms: time required by the device after enabling its=0D
+regulators or powering it on, before it is ready for communication =0D
+- minimal-reset-delay-ms: minimum amount of time that device needs to be i=
n=0D
+reset state for the reset to take effect=0D
+- input-report-header-address: this property and the rest are described in=
 HID=0D
+Over SPI Protocol Spec 1.0=0D
+- input-report-body-address=0D
+- output-report-address=0D
+- read-opcode=0D
+- write-opcode=0D
+- flags=0D
+=0D
+Example:=0D
+	spi-hid-dev0 {=0D
+		compatible =3D "hid-over-spi";=0D
+		reg =3D <0>;=0D
+		interrupts-extended =3D <&tlmm 42 IRQ_TYPE_EDGE_FALLING>;=0D
+		vdd-supply =3D <&pm8350c_l3>;=0D
+		input-report-header-address =3D <0x1000>;=0D
+		input-report-body-address =3D <0x1004>;=0D
+		output-report-address =3D <0x2000>;=0D
+		read-opcode =3D <0x0b>;=0D
+		write-opcode =3D <0x02>;=0D
+		flags =3D <0x00>;=0D
+		reset_gpio-gpios =3D <&tlmm 25 GPIO_ACTIVE_LOW>;=0D
+		post-power-on-delay-ms =3D <5>;=0D
+		minimal-reset-delay-ms =3D <5>;=0D
+		=0D
+	};=0D
--=20
2.25.1

