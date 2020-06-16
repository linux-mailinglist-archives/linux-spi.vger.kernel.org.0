Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B12D1FBD03
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 19:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbgFPRck (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 13:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbgFPRck (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Jun 2020 13:32:40 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F02C061573;
        Tue, 16 Jun 2020 10:32:40 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h5so21665664wrc.7;
        Tue, 16 Jun 2020 10:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1/rWQhYqkKv3AA+tgURnEw8UDH0QpH1z730vDcNorC0=;
        b=u/xL2YRB0FzdzPajA2xmnWxbOTOw2G3go/1daObGY0IJIUSScLcGbBdin4iNgSuX9e
         Jva4FgeQ1lQJn6GMzSo4FRMjnl95o92wHKgTouK7wOUbuFZEeVauKhH+KhJQBO5fB/39
         GpbAdv+IweWl2azYR/uQlzPlXMfjoes+jbuxv7rOWQtpPjypRf10RnuwJsUVUJ4aVUzu
         j6VJBsr5DjJB76bl0s61OH8YfBZkYthVTnobJKNfxxMQi7cxqZCajszGy8jesnGi9rNK
         Ui4FflTZQTtT+7CrC74aEoSy4AkYTZ6ryjENBQmSN7Fzt9FbwunIRNKZTaB1cD77b7rA
         2jQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1/rWQhYqkKv3AA+tgURnEw8UDH0QpH1z730vDcNorC0=;
        b=dc6Howsieh08+FxmmCBEcZZiRgCI4bfL5J7PdfJ1/a4/t+bDWX8f23kaArTQzJDTyQ
         te82bx1+vaHQx753wcGnLa5UTIU9GuNMOe0qNUvjUKv6Tzj0u7NtRVGpN9t0puu81M1X
         Hb38t+7DeDeLzLnb3MNImUjHD3QFxLitV/7blIvibz8/9Jxya4hGqgiC7zcmhaSm5vfg
         D1nLssyDHcclYyTZRT4JOiGE54GOwX/UNt3uK9qSRCZlM6BkXJnxk0Bk71ruYxIEVF64
         ph0ULEv0yvdeUKeFHR/HWRajks1c8yPinVLHMLjfKcmFxfUPG6wUnMOd6J3YhLcj4eMr
         RYwg==
X-Gm-Message-State: AOAM532SsT2KbvMJ87bCK7cU7ZeGwN0KLRkHSzHvUJIyrQwrPm2XqiIb
        Od+zlSFFX5hZ3myhAqOrExoFR7HuPVE=
X-Google-Smtp-Source: ABdhPJyLeoPqvD4+LxPE8fop2SvP4lmtgPFmNzRCmlzyHx4LIzbvjTK3qbGPiobkMsX74O3NXPiqkA==
X-Received: by 2002:adf:e84e:: with SMTP id d14mr4046243wrn.31.1592328758604;
        Tue, 16 Jun 2020 10:32:38 -0700 (PDT)
Received: from skynet.lan (90.red-88-20-62.staticip.rima-tde.net. [88.20.62.90])
        by smtp.gmail.com with ESMTPSA id f16sm5014402wmh.27.2020.06.16.10.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 10:32:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     broonie@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v4 0/2] spi: bcm63xx: add BMIPS support
Date:   Tue, 16 Jun 2020 19:32:33 +0200
Message-Id: <20200616173235.3473149-1-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

BCM63xx SPI and HSSPI controller are present on several BMIPS SoCs (BCM6318,
BCM6328, BCM6358, BCM6362, BCM6368 and BCM63268).

v4: simplify devm_reset_control_get_optional_exclusive return handling
v3: use devm_reset_control_get_optional_exclusive
v2: use devm_reset_control_get_exclusive

Álvaro Fernández Rojas (2):
  spi: bcm63xx-spi: add reset support
  spi: bcm63xx-hsspi: add reset support

 drivers/spi/spi-bcm63xx-hsspi.c | 12 ++++++++++++
 drivers/spi/spi-bcm63xx.c       | 12 ++++++++++++
 2 files changed, 24 insertions(+)

-- 
2.27.0

