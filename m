Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63B74F1AC1
	for <lists+linux-spi@lfdr.de>; Mon,  4 Apr 2022 23:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379210AbiDDVS5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Apr 2022 17:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379838AbiDDSQD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Apr 2022 14:16:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D543EA8F
        for <linux-spi@vger.kernel.org>; Mon,  4 Apr 2022 11:14:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D41E660DE3
        for <linux-spi@vger.kernel.org>; Mon,  4 Apr 2022 18:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B7F5C2BBE4;
        Mon,  4 Apr 2022 18:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649096046;
        bh=VYnRnWU3yeqo4xx/P9yaXwOT8GETW/dtByQJVhF6p64=;
        h=Subject:From:Date:To:From;
        b=f0DOhQapqiMlRVdsQSdrArEyhmvGIxqltfE9zK9I7TghtvS8tpy3Gl+paSxddnAFe
         kuTDpUtCX+HqKtC7yxdn2+rjAbakAWc0vLdTq2tyd2BzR8pRKB+amHQStz8iSw+zrA
         cZA1q7Q81ThkQE2bwUx+uwUmAGsLrmkoXo+5A7ZTdW1XAcsuiZ+LfCymYDuSAD0OTF
         4ZAQjzzyk4GGpuguEYB8c4k9IFEINr3w0nFjAAvekp/2NiRbrqwLjTsWLNVZ8mobZi
         E2MqfCWhIEPIT4qKcvOlGzHs12l7fIjxKE7nog9oHhMsf0lnaDadrLGnkl9izIUmZ1
         QePG6eAO4zXNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F331E85B8C;
        Mon,  4 Apr 2022 18:14:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164909604600.22481.8272585257889455540.git-patchwork-summary@kernel.org>
Date:   Mon, 04 Apr 2022 18:14:06 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Update the Icicle Kit device tree
  Submitter: Conor Dooley <conor.dooley@microchip.com>
  Committer: Palmer Dabbelt <palmer@rivosinc.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=605968
  Lore link: https://lore.kernel.org/r/20220117110755.3433142-1-conor.dooley@microchip.com
    Patches: [v4,01/14] dt-bindings: soc/microchip: update syscontroller compatibles
             [v4,07/14] dt-bindings: usb: add bindings for microchip mpfs musb
             [v4,09/14] riscv: dts: microchip: use clk defines for icicle kit
             [v4,12/14] riscv: dts: microchip: update peripherals in icicle kit device tree
             [v4,14/14] MAINTAINERS: update riscv/microchip entry

Series: External ECC engines & Macronix support
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Committer: Miquel Raynal <miquel.raynal@bootlin.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=609005
  Lore link: https://lore.kernel.org/r/20220127091808.1043392-1-miquel.raynal@bootlin.com
    Patches: [v10,01/13] spi: spi-mem: Introduce a capability structure
             [v10,02/13] spi: spi-mem: Check the controller extra capabilities
             [v10,03/13] spi: cadence-quadspi: Provide a capability structure
             [v10,04/13] spi: mxic: Provide a capability structure
             [v10,05/13] spi: spi-mem: Kill the spi_mem_dtr_supports_op() helper
             [v10,06/13] spi: spi-mem: Add an ecc parameter to the spi_mem_op structure
             [v10,07/13] mtd: spinand: Delay a little bit the dirmap creation
             [v10,08/13] mtd: spinand: Create direct mapping descriptors for ECC operations
             [v10,09/13] spi: mxic: Fix the transmit path
             [v10,10/13] spi: mxic: Create a helper to configure the controller before an operation
             [v10,11/13] spi: mxic: Create a helper to ease the start of an operation
             [v10,12/13] spi: mxic: Add support for direct mapping

Series: Support Spi in i2c-multi-instantiate driver
  Submitter: Stefan Binding <sbinding@opensource.cirrus.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=607335
  Lore link: https://lore.kernel.org/r/20220121172431.6876-1-sbinding@opensource.cirrus.com
    Patches: [v6,1/9] spi: Make spi_alloc_device and spi_add_device public again
             [v6,5/9] platform/x86: i2c-multi-instantiate: Rename it for a generic serial driver name
             [v6,6/9] platform/x86: serial-multi-instantiate: Reorganize I2C functions
             [v6,7/9] platform/x86: serial-multi-instantiate: Add SPI support
             [v6,8/9] ALSA: hda/realtek: Add support for HP Laptops
             [v6,9/9] ACPI / scan: Create platform device for CS35L41

Patch: [v11] spi: mxic: Add support for pipelined ECC operations
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Committer: Miquel Raynal <miquel.raynal@bootlin.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=610697
  Lore link: https://lore.kernel.org/r/20220202144536.393792-1-miquel.raynal@bootlin.com

Patch: dt-bindings: Fix missing '/schemas' in $ref paths
  Submitter: Rob Herring <robh@kernel.org>
  Committer: Rob Herring <robh@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=626437
  Lore link: https://lore.kernel.org/r/20220325215652.525383-1-robh@kernel.org

Patch: [GIT,PULL] Immutable branch with spi in i2c-multi-instantiate changes
  Submitter: Hans de Goede <hdegoede@redhat.com>
  Committer: Takashi Iwai <tiwai@suse.de>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=610764
  Lore link: https://lore.kernel.org/r/2062f567-9756-1e13-bb50-89c7211955fd@redhat.com

Patch: dt-bindings: Another pass removing cases of 'allOf' containing a '$ref'
  Submitter: Rob Herring <robh@kernel.org>
  Committer: Rob Herring <robh@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=618890
  Lore link: https://lore.kernel.org/r/20220228213802.1639658-1-robh@kernel.org

Patch: spi: qcom: geni: Simplify DMA setting
  Submitter: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=603752
  Lore link: https://lore.kernel.org/r/1b14e4ce91a33c16b2c655389c728071a9c9aa2e.1641643601.git.christophe.jaillet@wanadoo.fr


Total patches: 28

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


