Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58392352ACE
	for <lists+linux-spi@lfdr.de>; Fri,  2 Apr 2021 14:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbhDBMuY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Apr 2021 08:50:24 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37168 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhDBMuX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Apr 2021 08:50:23 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 131DqGu0040293;
        Thu, 1 Apr 2021 08:52:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617285136;
        bh=lVDHzX91Sk11Ck57RNIL8h0yHHmjpnWZIpiFJQIw4mA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lWOBR6vf3FbeYg1fc6P29N9DqjxHBXON/QGyoGdmCFWuaOClLuCW1/67+qVcOfk2u
         Y/yOglNRS7W2kcDj6TnDmuzSYgUhz1KGF7MM5rK8CH2BRVA3XHlFug7qpu0Kjpb/hz
         u9Pn7UmM6eZV7G/sUYI/giSf4n6rof/W/TQrbSQA=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 131DqGmD015312
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Apr 2021 08:52:16 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 1 Apr
 2021 08:52:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 1 Apr 2021 08:52:16 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 131DqGTr097711;
        Thu, 1 Apr 2021 08:52:16 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: (subset) [PATCH 0/4] Convert Cadence QSPI bindings to yaml
Date:   Thu, 1 Apr 2021 08:52:15 -0500
Message-ID: <161728504983.2096.1063574920554874294.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210326130034.15231-1-p.yadav@ti.com>
References: <20210326130034.15231-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 26 Mar 2021 18:30:30 +0530, Pratyush Yadav wrote:
> This series picks up Ramuthevar's effort on converting the Cadence QSPI
> bindings to yaml [0]. During the conversion process, I discovered that
> some TI device tree files were not using the compatible correctly. Those
> are fixed in patches 1-3.
> 
> [0] https://patchwork.kernel.org/project/spi-devel-general/patch/20201116031003.19062-6-vadivel.muruganx.ramuthevar@linux.intel.com/
> 
> [...]

Hi Pratyush Yadav,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/4] arm64: dts: ti: k3-j721e-mcu: Fix ospi compatible
      commit: f1b6f6e7f595ed66ba5f5d628df3d259218d584b
[2/4] arm64: dts: ti: k3-j7200-mcu: Fix ospi compatible
      commit: 0e941f496a8bdc47d34199c17f81b09b0dbe14ae
[3/4] arm64: dts: ti: k3-am64-main: Fix ospi compatible
      commit: 112e5934ff3a7505e583365213a27f990922b76b


All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/nmenon/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

