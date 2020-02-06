Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C92FD154709
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2020 16:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgBFPGk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Feb 2020 10:06:40 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35699 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbgBFPGj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 Feb 2020 10:06:39 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so2893974pgk.2;
        Thu, 06 Feb 2020 07:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UZFkCGZVwQwduBtZ/3jHg/ruPMYP9eMWaKEsW4KMUwM=;
        b=UigLDjPkKII20d9oN18ihCRA+NuoxXY3ObqaZ3RjhodSH0/6ueflU0o61aPlfgCwIh
         KglkR2y2S/Jx8gTz7VHx0B/3vQMbZ61/yPmmNFGOLO6zJediuida0L5lvNLgQyn+7aqJ
         HfqZs3VpeTq1FRz5YjYJwIRf1za1q5C8cSzCHWnMdR0NxdbjbNuxiny+ZK9obbGHVBgV
         OEYJB8WYCqHm2zG7aCcKjxGLHc2SHP1NPlncruJd/Ly3NPUXanWA7cmQq0CRtMU5yvup
         Lyt49IGP7x7afuVLBE+PIWcT8IfXv0rSwioT0FBXNJFzbgKjPhYiMFjit3U2I6yn87St
         ZFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UZFkCGZVwQwduBtZ/3jHg/ruPMYP9eMWaKEsW4KMUwM=;
        b=MJeRrkTO9rifDIWhjHe6jgNSkYa28CedvSf5fYEZ77z+hlK/I8NgtsJxr3T0ulnV4h
         XpLryuwMFnheWKny52OrwCEw63QHkiwSDuAqzwgzsUGO4JX/DhkvgT2J3wpMVCKrN1HZ
         DkGbZP/o67Jn0g5KsgbKWbhFV5wcNjnijfRvetnhHFr2xPzwDzlhr6FgIExBfR9dqqBB
         Ziq0c+DVi7SGOXF2gPbChIc9d7TXB5Fb8z6BiKc6jmvldSTVQIsOgwFDkcWw2Q2ZQ08O
         5+9BTa4Qye+EEH5z/9LHbVYqEkaOjY9PRMg5ZZsX8C3UYJvMBVNBGIYDWKynbk9rorl5
         NyPA==
X-Gm-Message-State: APjAAAX+ewA7uJvOqQ7pRd+2to1Vsya68uWhat7KzAoxJmpccKCPVJ2x
        W3hS7rgN7/B8b1QYkLkz3i4oMdiCc54=
X-Google-Smtp-Source: APXvYqyL2WFmNAXlCFyO7pKJgnGP32rmFdvVLLTr21oEjc7gLrKgr9uC/DhbXqHRZ5LRPK397UR/Ow==
X-Received: by 2002:a63:778c:: with SMTP id s134mr3964066pgc.451.1581001598790;
        Thu, 06 Feb 2020 07:06:38 -0800 (PST)
Received: from localhost.localdomain ([2001:19f0:7001:2668:5400:1ff:fe62:2bbd])
        by smtp.gmail.com with ESMTPSA id 64sm3748157pfd.48.2020.02.06.07.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 07:06:38 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Chuanhong Guo <gch981213@gmail.com>
Subject: [PATCH v2 0/2] spi: add driver for ar934x spi controller
Date:   Thu,  6 Feb 2020 23:06:24 +0800
Message-Id: <20200206150626.708649-1-gch981213@gmail.com>
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

