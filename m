Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0AE17EAD4
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 22:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgCIVIy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 17:08:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46611 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgCIVIx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 17:08:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id n15so13014312wrw.13;
        Mon, 09 Mar 2020 14:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kAEXGIBTihs2aEXLy+/u0H3T9UnyJrJyBGNNvIDBqSQ=;
        b=TWCaCqSPmiFJmxJN3aCnLwv2ssaFFm8FOa/wqZJCht7oJDCzhqWxWQvZMp+qr/Rait
         dNI9vOe3IBXvfj9BbQnNrXiFwacEQB6Jr94SD7J8TABorbw9SlGzwCm/u2qEm7PCn+SV
         hBfbwPfyNKANya8pIjT4oHQwV6zLNgRAcYdEOXxhqHsYoCVrtqDA7OvN4vgVyiFgj11o
         nmDgdETMu6lU0pPbWSjP2XsXZhLR4bWHm+HTfEK7pg5yobgJ60pxu6BmfqiNB48T7/HU
         WxJ8Fh3+szMQwrChXAfUwnH+XVZ0rglHvMIlgypPpn6KgqEuAnKCLedhqpntKQliZB6t
         l3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kAEXGIBTihs2aEXLy+/u0H3T9UnyJrJyBGNNvIDBqSQ=;
        b=KJSUv4mQ6KbTPlwF6w0hwcCrcJ6py//iztGo8G0ZM0OsJEN4r3QipoTE8gqg+sYwqG
         xpQeISBzr3IlOPOQuAhrUTYk+sRMSrz2LZdTWM6A1X4n38hCqmZwENyTmLG9wtNLl17J
         YkY5HiI6mHR3fDx8f5FpvpMnT5disEK4XCVjjeNCNCRK+b7XbpFs74eIRmswJeY719+X
         7Gi6J7VLwS6CGi/4dq+n8Lm/5HLO/r41Y8ujHT94762SOaAmyhGoxeILhWlz4hEAtf3G
         zyRGxux/dlhV8HX/9K1n+fh1Ou3LSzX9xRJq0lWCwe+ROLhfPuYAIf0S9/f9k2f3jpii
         fn0A==
X-Gm-Message-State: ANhLgQ1F3LGCbSjEsajtLiDjjj57odWpfgUEXulI0eUcdm5sUyvrXnaB
        fg2X4rtssL0UwvR1Q89n0hw=
X-Google-Smtp-Source: ADFU+vs65US5DrN5du6jklN9RnuRrgYN46Sddnjqilsx4BlpkM4+fIUcFKk+y5w0p/LeO6uK722rZQ==
X-Received: by 2002:a5d:5090:: with SMTP id a16mr20484540wrt.191.1583788131502;
        Mon, 09 Mar 2020 14:08:51 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id j205sm1016275wma.42.2020.03.09.14.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:08:51 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v2 6/6] arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS
Date:   Mon,  9 Mar 2020 23:07:55 +0200
Message-Id: <20200309210755.6759-7-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309210755.6759-1-olteanv@gmail.com>
References: <20200309210755.6759-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

For debugging, it is useful to have access to the DSPI controller
signals. On the reference design board, these are exported to either the
mikroBUS1 or mikroBUS2 connector (according to the CPLD register
BRDCFG3[SPI3]).

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v2:
Change compatible string for spidev node.

 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index bb7ba3bcbe56..13555ed52b89 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -83,6 +83,20 @@
 	};
 };
 
+&dspi2 {
+	bus-num = <2>;
+	status = "okay";
+
+	/* mikroBUS1 */
+	spidev@0 {
+		compatible = "rohm,dh2228fv";
+		spi-max-frequency = <20000000>;
+		fsl,spi-cs-sck-delay = <100>;
+		fsl,spi-sck-cs-delay = <100>;
+		reg = <0>;
+	};
+};
+
 &esdhc {
 	sd-uhs-sdr104;
 	sd-uhs-sdr50;
-- 
2.17.1

