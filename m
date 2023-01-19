Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80281673FEE
	for <lists+linux-spi@lfdr.de>; Thu, 19 Jan 2023 18:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjASR2o (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Jan 2023 12:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjASR2n (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 Jan 2023 12:28:43 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1042F4C6E8
        for <linux-spi@vger.kernel.org>; Thu, 19 Jan 2023 09:28:36 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o17-20020a05600c511100b003db021ef437so1800360wms.4
        for <linux-spi@vger.kernel.org>; Thu, 19 Jan 2023 09:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=SiCKnh1A0rDMxjwJ+8FnUzsil063oz6GksT8G3Rwl1Q=;
        b=LNyDZCFVPiujevJ73s6D8i8VYTVUrPVuBfnKCz/1eF9v8zJ1YHo2X+2a8USNAxW2Pf
         1TfCKKNetUvikg8WC6XF9Hz9zA1NsativSJ9hCXGTsAbP3GbI59uTPtZVaola4KBBepZ
         X4cb9ntmYcm0ryvauWzvktBUqVLK9q/UEPS8cuOt3cTIwcBgls+/1vOteQRJucRyJpv8
         sLp9akoqJWIgfLE+djMg96Twbmp24gGNnZQom/lotQm5G2QDHIs01iiEFRQ/iGAaeJyh
         Hhe7XFnEE61hahC0nLxuqhzPaUshHoB/CGwBSRAt0C9RGCr3MMq5zz3f/c7oiES+nUTa
         JZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SiCKnh1A0rDMxjwJ+8FnUzsil063oz6GksT8G3Rwl1Q=;
        b=a18hsR2nH22FvoLK6pJyqGRpHnwukfVqumaDIWF52NeAlOzOdjvuNLrzsE9orT/Idy
         Y/WJnAFxDmMsMJMyEtqUz5tPSpbzSvEWZgJnjgZnNs6yrOfc9zBZBZ7JbF7MKBBJLzcd
         LhYwWcR2oC6JJMy9RkNZ+8feSlbsgvcvEXoSTe240xWokeItlgHrkgTZTmkKLJTWIfdp
         w9bDL2tYJbdK3NRMR0JiA2/Cn8Z3BAiWFMDVknwVflQUSw0PrBVz3OWAEnlTyA35nH/r
         peF+pdcjOkIacrGRHkQnmQrMXtm4YLhNYTTzeGI3swc33A184nA6qWpJC1jsbfQALXR4
         EQpA==
X-Gm-Message-State: AFqh2ko7twbvMzEowvCB46DRCB7eoEHpZxGYePe+22rWlS3egaP6vnAI
        HR7d/8nWiG6dhUiMatkm442FtA==
X-Google-Smtp-Source: AMrXdXuzWfZ4bHJUCis4rIhlmdVCuixhWWJZXp5n2L6sMuCx+1lBtA//Znp4g3Gq1IVPthS7DYhCkQ==
X-Received: by 2002:a05:600c:c16:b0:3da:26e5:10b6 with SMTP id fm22-20020a05600c0c1600b003da26e510b6mr11369469wmb.30.1674149314614;
        Thu, 19 Jan 2023 09:28:34 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id h11-20020a05600c314b00b003db2e3f2c7csm124186wmo.0.2023.01.19.09.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 09:28:33 -0800 (PST)
Subject: [PATCH v2 0/2] Add MediaTek MT8365 SPI support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIALJ9yWMC/32NQQqDMBBFryKz7pQkJqJd9R6li0kcakATSaIg4t0beoCuPu/D+/+EzMlzhkdzQu
 LdZx9DBXVrwE0UPox+rAxKqFZI2eNS+rYzmFePeVvXmAqKceisM4Y0CaiipcxoEwU3VTVs81zLyecS
 0/E72mWN19/NXaLAXitSko3Qg35aOmZvE99dXOB9XdcXy2eP+LwAAAA=
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 19 Jan 2023 18:28:18 +0100
Message-Id: <20230118-mt8365-spi-support-v2-0-be3ac97a28c6@baylibre.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1635; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=dnb60EIwMZF/t+qpJpOhEHQaGAuRMDbKO4dBLwI/lsY=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjyX3BW9YqoQgrhB3ntOOv0c01jfvNFgBDq3Hjp16A
 IDcYNZKJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY8l9wQAKCRArRkmdfjHURdTMD/
 4vL5RVu602wStR5BIiJRPHWR2ipZln37Rd1Uxu4wsWtBJcIYnwimBbnuzSrzprXdef2u5RMj145cc5
 186M96G/b999VDfbUtvejkTzAQkOVCOXL0mPlm+tcCqeuqPuftIFrswP5Tv5bDbk8uO8nVLONIeqAx
 xVGEe+oqw27aDUlA2bJxMlBFSqYcvSvhPtp7ZERwwJuoHMiO+HngE/YrhkPB9MGUvTrkEXXN90lOFo
 m/QDs/httd7vB21rsdMQvQJtVmMAxq1amDFfXirs6pEO/sKWNgwmsOx2Tqak3CoMEDVqWYJZvOdqo/
 y0gYXG3Okazu4vleANuHxGk6maIutIlCBvn8qChA08zD7zP0x5zroIqHrSrHmRjLcUa0ecvGBXU7XN
 WSjWyNvvagGFafo+iuWm1ZSErYAfS24KTQUrcflfsPQ524KnEOs8Sav8bzWsT9CUHJnTjcpW2da0l0
 PzGyhCVKPXMZZ9LaGV6FcCZEO0f3Vb2n6DrrySNOzVkT1JrVCo+fmEnf5w8s0K178GW8xE5EI1RS3Q
 IfFbVlFRzy0zY4CoNe4p2LlXz0z6D/CtzV21kh0H2SmGi2EbWVaMGf3KI2MCbQ6DxqomeVtNGz+nS0
 UlWwYQcPf+9B+Ivq1yNHAgttYMvG7B7ruEVYB9H6HWts88rVYxZCI2kDMX5g==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,
This patch series adds SPI support for MT8365-EVK board.
The SPIDEV is enabled, it can be used through the board pin header,
as described directly on the PCB.

This series depends to another one which add support for
MT8365 SoC and EVK board. Link [1].

Test:
- Loopback MOSI and MISO pins
- Issue the following command:
spidev_test -D /dev/spidev0.0 -v
- RX line should be the same as TX line.

Regards,
Alex

[1]: https://lore.kernel.org/linux-mediatek/20230101220149.3035048-1-bero@baylibre.com/

To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-spi@vger.kernel.org
Cc: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
Changes in v2:
- Add Amjad Ouled-Ameur SoB.
- Link to v1: https://lore.kernel.org/r/20230118-mt8365-spi-support-v1-0-842a21e50494@baylibre.com

---
Alexandre Mergnat (2):
      arm64: dts: mediatek: add spidev support for mt8365-evk board
      spi: spidev: add new mediatek support

 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 24 ++++++++++++++++++++++++
 drivers/spi/spidev.c                        |  2 ++
 2 files changed, 26 insertions(+)
---
base-commit: 8b6cfcce3ce939db11166680a57253c39110f07e
change-id: 20230118-mt8365-spi-support-0d96bc55a4a0

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>
