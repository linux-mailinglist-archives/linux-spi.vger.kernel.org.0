Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 740E4155259
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2020 07:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgBGGPz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 Feb 2020 01:15:55 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45270 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgBGGPy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 Feb 2020 01:15:54 -0500
Received: by mail-pg1-f193.google.com with SMTP id b9so560869pgk.12;
        Thu, 06 Feb 2020 22:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oIWvQKjeURh41o5jLiCm8zK/D7CveIajHCiTf3CbOf4=;
        b=rA+pSDl2UEhU7r4KgW1R90UuKoei0GVpzWqpQaPSMYl2XN5+EDo808cRepHaOfuBZ8
         dcRRQTfA4Bsg0lwBPH8y14tiFReDeFMEqjPUvmkDKULpNjklhJFmVJrj3ieP3lMRqUiV
         y7gUJMY3bH5vfJphpztQP8nfga0zqcOx/o7ogozY/KpM99WizPdRiIqD9CdQJzwARfjF
         hqLOxksfH4Vk920UA2YRyjiT+VzAxgV3wk6CM/6Dt83hH1JGLfLVsQ2nGC6YOS5kD58G
         90/i7fIc8yOOnzbpWeLFRkN86nUPJlcVMLUT512gN48G4IWeRWjw+7Hxiz+J28T1pRpy
         lxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oIWvQKjeURh41o5jLiCm8zK/D7CveIajHCiTf3CbOf4=;
        b=FfkhxRcm049Wrp+zKwpdxluPvHoergZr67XmLMHuF1DtE82CCxCz9WgXC4U2jQDJlE
         /oiC5Rqz3ZgyzeGJRnJs38ODS4Fi4KvYopa65rDQEiGkDFV7sGbc+CsUGbuRGa3KtTk8
         DEc1tC6ratIe/uqMoJ8U+DLC19ixperARjMDQETEZv8X8uD23XtT0eg3qaVPTnHW+zIY
         tFGAYPs83YvnPVrLiCsQ+8UyrzUYBITy9laks69HB8LF7Sn0cRwh3VxyiGNjhgmeMdYW
         hX5xrMktD60/6Juw6urxRmk2wLfk5nSp0LQ61cMbYnoiuUa/9dv5ge2j6dfycOlO2dfT
         KnTw==
X-Gm-Message-State: APjAAAUQ2XA/Wo4l29hAxXJtFVZ2YQp784gTDMhQvUa6nVxyamFu43LX
        z4f+kr2+qrA4gcKAKlEhGat9k+Y2JRfhxg==
X-Google-Smtp-Source: APXvYqwd6QSW6mUkT1II/pwo9nRPlkyFskOSSckbiAzAKYrTCZR/KF0Tj//AWGcLBv0zW9hwbxa0Jg==
X-Received: by 2002:a63:f0a:: with SMTP id e10mr7170520pgl.402.1581056152556;
        Thu, 06 Feb 2020 22:15:52 -0800 (PST)
Received: from localhost.localdomain ([2001:19f0:7001:2668:5400:1ff:fe62:2bbd])
        by smtp.gmail.com with ESMTPSA id gc1sm1127414pjb.20.2020.02.06.22.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 22:15:51 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Chuanhong Guo <gch981213@gmail.com>
Subject: [PATCH v3 0/2] spi: add driver for ar934x spi controller
Date:   Fri,  7 Feb 2020 14:14:04 +0800
Message-Id: <20200207061406.1735079-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This controller is a superset of the already supported qca,ar7100-spi.
Besides the bit-bang mode in spi-ath79.c, this new controller added
a new "shift register" mode, allowing faster spi operations.
This mode doesn't need all the bit-bang code in spi-ath79.c and needs
a different clock setup, so I decided to write a new driver for it
instead of extending current spi-ath79 driver.

Change since v2:
fix binding documentation check.

Changes since v1:
1. change comment at the beginning to C++ style
2. rename ar934x_spi_transfer_one to ar934x_spi_transfer_one_message

Chuanhong Guo (2):
  spi: add driver for ar934x spi controller
  dt-binding: spi: add bindings for spi-ar934x

 .../bindings/spi/qca,ar934x-spi.yaml          |  40 +++
 drivers/spi/Kconfig                           |   7 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-ar934x.c                      | 229 ++++++++++++++++++
 4 files changed, 277 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/qca,ar934x-spi.yaml
 create mode 100644 drivers/spi/spi-ar934x.c

-- 
2.24.1

