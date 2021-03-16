Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD6E33CF15
	for <lists+linux-spi@lfdr.de>; Tue, 16 Mar 2021 09:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbhCPIAK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Mar 2021 04:00:10 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:35323 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbhCPH7x (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Mar 2021 03:59:53 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4F05L00TpJz1qtdm;
        Tue, 16 Mar 2021 08:59:52 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4F05L00GzXz1qqkr;
        Tue, 16 Mar 2021 08:59:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Cx8vP1OyQ_Pz; Tue, 16 Mar 2021 08:59:50 +0100 (CET)
X-Auth-Info: 5fA7AzyF+Ql/xb+Nc4iit4/BKi/tgQXd8vojv+JJC/8=
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 16 Mar 2021 08:59:50 +0100 (CET)
Received: from pollux.denx.de (pollux [192.168.1.1])
        by mail-internal.denx.de (Postfix) with ESMTP id 9B03D181A2B;
        Tue, 16 Mar 2021 08:59:30 +0100 (CET)
Received: by pollux.denx.de (Postfix, from userid 515)
        id 74D261A0092; Tue, 16 Mar 2021 08:59:30 +0100 (CET)
From:   Heiko Schocher <hs@denx.de>
To:     linux-spi@vger.kernel.org
Cc:     Heiko Schocher <hs@denx.de>, linux-arm-kernel@lists.infradead.org,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] enable flexspi support on imx8mp
Date:   Tue, 16 Mar 2021 08:59:26 +0100
Message-Id: <20210316075928.1763460-1-hs@denx.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

add compatible entry in nxp_fspi driver for imx8mp

@Shawn: If this series is accepted, can you apply the DTS patches from
series v2?
http://lists.infradead.org/pipermail/linux-arm-kernel/2021-March/643292.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2021-March/643293.html


Changes in v4:
rebased against:
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
a43e89624baea ("Merge remote-tracking branch 'spi/for-5.13' into spi-next")

Changes in v3:
- seperate spi changes from series:
  http://lists.infradead.org/pipermail/linux-arm-kernel/2021-March/643289.html
  into own series as Kuldeep suggested and rebased against
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
  144c79ef33536 ("Merge tag 'perf-tools-fixes-for-v5.12-2020-03-07' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux")
- no changes, rebased against
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
  144c79ef33536 Merge tag 'perf-tools-fixes-for-v5.12-2020-03-07' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux

Changes in v2:
- work in comments from Marco
  add own compatible entry for imx8mp

Heiko Schocher (2):
  spi: fspi: enable fspi driver for on imx8mp
  dt-bindings: spi: add compatible entry for imx8mp in FlexSPI
    controller

 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt | 1 +
 drivers/spi/spi-nxp-fspi.c                             | 1 +
 2 files changed, 2 insertions(+)

-- 
2.29.2

