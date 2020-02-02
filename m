Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03C5914FD28
	for <lists+linux-spi@lfdr.de>; Sun,  2 Feb 2020 14:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgBBNAN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 2 Feb 2020 08:00:13 -0500
Received: from mail-yw1-f45.google.com ([209.85.161.45]:46809 "EHLO
        mail-yw1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgBBNAM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 2 Feb 2020 08:00:12 -0500
Received: by mail-yw1-f45.google.com with SMTP id z141so10004339ywd.13;
        Sun, 02 Feb 2020 05:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g41y4TduYyE4Zq7XaNgfQZ1uBYpJA8BiIYoPp6mgrtE=;
        b=WqHN4WNpKRHbz5KbVH2wcfUM4s+eLtY9OB1l0MbE5xT7J+rxS0aIn+7YdN6npIGcj4
         ufTxwcx8G+4HpLKqBnUZ+rvW2TGwx78OtAVlQOf7mjYPqIFlD7Us5llDzZ5gjQtPWhQ7
         chCniMaQ6xBLI1Key30/9fisPEg9efhoDskNpki8mmFHbofIif5s1tgZyfgCuGTz75/V
         lszW4MSOXINJDGYfCFGrAflmi7s0zwSPrQhaHvJjCvpMpn1ePJ1NKK1T6L/GtoTOAkdr
         kmylhWwtX6Ed9iSE6LJNIQm8SX68upoP9DQz4m3rCCK3LEnZqXgCu2DhTf7l2SXfOky6
         OxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g41y4TduYyE4Zq7XaNgfQZ1uBYpJA8BiIYoPp6mgrtE=;
        b=mcPq6O/W+lXvAvZdMPA76FjeFDxrHyMGTF2POIBFObpVOuAJhUzRaCwOy4/zQC4eQh
         aKIu+O5nIb2q/gIFPlKBD3Sp4Jg+pbgCDnzGJLOvCj28J9BiY8CHrJDukADenuSHEY41
         vp9qZjC5Z4EPWV0IXGw53JX1PHqv9gcaZqO9+VrOl6Lr/hpfZFO9iBMU2IKIp1rGDJYn
         AZmhG1rL3SBchCIskTtXGUptJFYh5XfEH53t5Rrl3Tlt16ASunxKlv8/saRnCaMVeNAI
         DYNAXeu05qpmgaguUOW67gELuye4e+jFA+KGoY3uM7eai7/dgbg/zyP3HsRCP17zIK68
         vALA==
X-Gm-Message-State: APjAAAVxB2rOphDB1yL0GisoMw9cAQDvZIXXupLc9qLCmNLEquhZ0TQU
        JCZR4prIR4fMrRW1nPDz246zb5P/3Wg=
X-Google-Smtp-Source: APXvYqxESfjVSs4DtOWtMq7VLTeIVuSJZKG8ga+iAtfaG5fC/Sjp0XF06H7gjLbeQcvU/yBzLMS43Q==
X-Received: by 2002:a81:a703:: with SMTP id e3mr15769631ywh.71.1580648408393;
        Sun, 02 Feb 2020 05:00:08 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id m137sm7090013ywd.108.2020.02.02.05.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 05:00:07 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Adam Ford <aford173@gmail.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH V2 4/5] dt-bindings: spi: spi-nxp-fspi: Add support for imx8mm, imx8qxp
Date:   Sun,  2 Feb 2020 06:59:49 -0600
Message-Id: <20200202125950.1825013-4-aford173@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200202125950.1825013-1-aford173@gmail.com>
References: <20200202125950.1825013-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support for nxp,imx8qxp-fspi and nxp,imx8mm-fspi do the bindings
document.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2: No change

diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
index 2cd67eb727d4..7ac60d9fe357 100644
--- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
@@ -2,6 +2,9 @@
 
 Required properties:
   - compatible : Should be "nxp,lx2160a-fspi"
+			    "nxp,imx8qxp-fspi"
+			    "nxp,imx8mm-fspi"
+
   - reg :        First contains the register location and length,
                  Second contains the memory mapping address and length
   - reg-names :  Should contain the resource reg names:
-- 
2.24.0

