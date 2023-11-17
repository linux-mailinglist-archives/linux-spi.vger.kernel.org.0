Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940E07EF83A
	for <lists+linux-spi@lfdr.de>; Fri, 17 Nov 2023 21:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjKQUN5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Nov 2023 15:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjKQUN5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Nov 2023 15:13:57 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE9D10D0
        for <linux-spi@vger.kernel.org>; Fri, 17 Nov 2023 12:13:53 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b2e73a17a0so1480390b6e.3
        for <linux-spi@vger.kernel.org>; Fri, 17 Nov 2023 12:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700252033; x=1700856833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daUtcUgvD3JlASmZskT09A6jBu8ff2l03YGGYSvkuOo=;
        b=f48DKjAEIQUdrbqTo8CyXZNyvcYeKbLZzgsbK9bp6xrsHmzxpAXHkNPhWNfRkTSaLa
         0S/L9/iwFFvnwYMTjARBSJg3tj8Nb4n9UYVr9cQ0+/A7YKRIr8xhMD34l/INVH9noRdv
         9sOMzurGwze+y4Z16rKZnoMzqdj7ZsHnFWAFZsmIJPnZM5Ysl96ymCgwGMcU+1Yo+grr
         R2BMwrIsnXk1o7hHcd4VHpErxPyU2y242szks8KOljLatQlm48qqF/67x7UV5cEjzZF/
         DOtJgqQZNeC9twILU8f8qd/LocFsJI1WtV6R6aSTts6gmTUm+Hj8/l69wZ17ldD5twCc
         xi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700252033; x=1700856833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=daUtcUgvD3JlASmZskT09A6jBu8ff2l03YGGYSvkuOo=;
        b=NplrLb2n/21PgYrDpR1My/dS4Ezz6IO3vV+4iVD5Q5FHDiZhuRlPt1FJOQaMNi035a
         qFmzniz5GaBYLLgFBURTAl0MYDLerxIr7EMFjsVfsgadTLQB6bGYkfvlEhxtBdgd6pAq
         jhceABdRhinmIPZDYdGH8p7ClD0fmweU/+UdPz0Pl912zz3D51N5/w08nZtmohcK7iI5
         5yjMGdPNDKZV3KDJXFx8g9C5HxaIt7MNnAdjTLF8J3j54lJCZPVdW/9Sk7KtWtIwhsbn
         R7z0kC1k6AXixBYXD/tDYKM4Dr2UZGeqCX/GK9i5b5GVjuu1focyHGJtKP1y4MzNmj+F
         /w9Q==
X-Gm-Message-State: AOJu0YxpTMgE/+/b8d8OA8zHCT0cmj9KLfNJz7XK6L05uSZY7khMyh5a
        2/nQD14+JQRRugle+qJNranQj/zGDPf89OyeALuu9w==
X-Google-Smtp-Source: AGHT+IGupY9tgQkSOvQ1he/qTdneFPbPBSmCn8gJ3wctSyTP/DRvtzXTw5+16bwfGWkofb9g09taVw==
X-Received: by 2002:a05:6808:1704:b0:3b6:d617:a6f7 with SMTP id bc4-20020a056808170400b003b6d617a6f7mr595509oib.3.1700252032911;
        Fri, 17 Nov 2023 12:13:52 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id l21-20020a544515000000b003a8560a9d34sm393814oil.25.2023.11.17.12.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 12:13:52 -0800 (PST)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc:     David Lechner <dlechner@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/14] MAINTAINERS: add entry for AXI SPI Engine
Date:   Fri, 17 Nov 2023 14:12:53 -0600
Message-ID: <20231117-axi-spi-engine-series-1-v1-2-cc59db999b87@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117-axi-spi-engine-series-1-v1-0-cc59db999b87@baylibre.com>
References: <20231117-axi-spi-engine-series-1-v1-0-cc59db999b87@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The AXI SPI Engine driver has been in the kernel for many years but has
lacked a proper maintainers entry. This adds a new entry for the driver
and the devicetree bindings.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

Note: This work is being done by BayLibre on behalf of Analog Devices Inc.
This is why the maintainers are @analog.com rather than @baylibre.com.

 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97f51d5ec1cf..a40f61ad5843 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3415,6 +3415,16 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
 F:	drivers/hwmon/axi-fan-control.c
 
+AXI SPI ENGINE
+M:	Michael Hennerich <michael.hennerich@analog.com>
+M:	Nuno Sá <nuno.sa@analog.com>
+R:	David Lechner <dlechner@baylibre.com>
+L:	linux-spi@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
+F:	drivers/spi/spi-axi-spi-engine.c
+
 AXXIA I2C CONTROLLER
 M:	Krzysztof Adamski <krzysztof.adamski@nokia.com>
 L:	linux-i2c@vger.kernel.org

-- 
2.42.0

