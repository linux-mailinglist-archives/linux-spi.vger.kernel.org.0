Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECEA71F4860
	for <lists+linux-spi@lfdr.de>; Tue,  9 Jun 2020 22:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgFIUyZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Jun 2020 16:54:25 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:23444 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727023AbgFIUyZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 Jun 2020 16:54:25 -0400
X-IronPort-AV: E=Sophos;i="5.73,493,1583161200"; 
   d="scan'208";a="49231667"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Jun 2020 05:54:23 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id E415F40EA252;
        Wed, 10 Jun 2020 05:54:20 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/2] Add MSIOF support for R8A7742 SOC
Date:   Tue,  9 Jun 2020 21:54:12 +0100
Message-Id: <1591736054-568-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi All,

This patch series adds support for MSIOF on R8A7742 SOC.

Cheers,
Prabhakar

Lad Prabhakar (2):
  dt-bindings: spi: renesas,sh-msiof: Add r8a7742 support
  ARM: dts: r8a7742: Add MSIOF[0123] support

 .../devicetree/bindings/spi/renesas,sh-msiof.yaml  |  1 +
 arch/arm/boot/dts/r8a7742.dtsi                     | 64 ++++++++++++++++++++++
 2 files changed, 65 insertions(+)

-- 
2.7.4

