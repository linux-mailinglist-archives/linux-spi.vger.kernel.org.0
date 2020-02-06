Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4278154096
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2020 09:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgBFIp2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Feb 2020 03:45:28 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36221 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbgBFIp1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 Feb 2020 03:45:27 -0500
Received: by mail-pf1-f196.google.com with SMTP id 185so2759869pfv.3;
        Thu, 06 Feb 2020 00:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wHMzzdNcx5RlxuI3hSgHWmzifyCl/PTTXZRqGI2clPQ=;
        b=D64mGAuMmnR2djNUWp5EZ7ubeKQnN6ZYsoV0ViYEt0JDt+r2Jsql3hBBWbx++lAZ7T
         Ada7ebyqIuMTibgrGITxYzL1l7naC3KI4Eu/vOvU/LLzZG46XGs7bhyJS3LvJZmpmKJA
         TEaVK3m3SaPGQ3KuE/DM8T2PkUhWReIFHXycGGuOGptfcxxzSGFjH5/sbf3Poc+nHpJP
         IAL6iW0Xlm7pbKB31qo1hJsDRuWFR1wjJrKCelGmb8hwLEBv7CLuSFVl9g4D1fPU9aR0
         rVAtVSekNL6FKjPLO3ZteeM9OnbxwyEFN8xJZSKpbX0I9JmphszodLrc21bltHJOP72O
         AboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wHMzzdNcx5RlxuI3hSgHWmzifyCl/PTTXZRqGI2clPQ=;
        b=IcdXxjMUrWxLXRG9YIn978egS7zID/KkuxVfH5ZL0nduIkufBQcV+10T8gcmbaX4qT
         Phjr1iN6cRHR4jpx75vjRwg81881/++oscLXC+4FQMLA0QrziKGe4sfCVvnildiQGkYi
         xUud/HpyPpfMkIADw5rqeuryB5kJOjlgTsKbrN3RyCwheZQlYPzVFOkFxBYj8w+73DpE
         YL/IkBRvBwDuKmx9I4T2oeZlVFvZjydi9DOLiJgQhQRkBjoS0Ks6lNZpbXINEdnKCipZ
         njMi1pzVl7AeAn03pitNMCryETAUhYQ9nxoM4hzDniSCt7+kyOQexs0B58E7idsCnYNv
         CVEQ==
X-Gm-Message-State: APjAAAXpttBwucfZKWpHKQ0v7MjgO5ZjZp4WKZR5I0v6yc+wUyb7LQUP
        tPS+zhFiNzwZK478UeEBC0nPP6Gg3vbpQQ==
X-Google-Smtp-Source: APXvYqxc7qVnFyuPuhY12zzAcgvd2WCBFXssIB/cN06U5Zlg36d4O/X97NCgRK8FLmkU8EpsCbqrGg==
X-Received: by 2002:a63:30c2:: with SMTP id w185mr2516068pgw.307.1580978727038;
        Thu, 06 Feb 2020 00:45:27 -0800 (PST)
Received: from localhost.localdomain ([240e:379:947:2855::fa3])
        by smtp.gmail.com with ESMTPSA id 6sm2638370pgh.0.2020.02.06.00.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 00:45:26 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Chuanhong Guo <gch981213@gmail.com>
Subject: [PATCH resend 0/2] spi: add driver for ar934x spi controller
Date:   Thu,  6 Feb 2020 16:44:41 +0800
Message-Id: <20200206084443.209719-1-gch981213@gmail.com>
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

Resend the patchset because I forgot to CC documentation maintainers
Chuanhong Guo (2):
  spi: add driver for ar934x spi controller
  dt-binding: spi: add bindings for spi-ar934x

 .../bindings/spi/qca,ar934x-spi.yaml          |  40 +++
 drivers/spi/Kconfig                           |   7 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-ar934x.c                      | 230 ++++++++++++++++++
 4 files changed, 278 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/qca,ar934x-spi.yaml
 create mode 100644 drivers/spi/spi-ar934x.c

-- 
2.24.1

