Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEB5704EE7
	for <lists+linux-spi@lfdr.de>; Tue, 16 May 2023 15:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbjEPNMi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 May 2023 09:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbjEPNMg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 May 2023 09:12:36 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9AFF188;
        Tue, 16 May 2023 06:12:33 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8DxzOo+gWNkVCkJAA--.15794S3;
        Tue, 16 May 2023 21:12:30 +0800 (CST)
Received: from user-pc.202.106.0.20 (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxkrA5gWNkXF5jAA--.40062S2;
        Tue, 16 May 2023 21:12:29 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH v10 0/2] spi: loongson: add bus driver for the loongson spi
Date:   Tue, 16 May 2023 21:12:22 +0800
Message-Id: <20230516131224.25481-1-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxkrA5gWNkXF5jAA--.40062S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxWFy3Zr48trWrJw4UuFW5Awb_yoWrtw43pF
        W5Cas8Kr48AF4xArs3Aay7uFyFv3y5J39rXay3t39ruryDZ34UZryktF1rZr9xAFsIy3Z2
        qFy0grs5Ga4UZr7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7xFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487
        Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxV
        CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
        6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
        WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG
        6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
        1UYxBIdaVFxhVjvjDU0xZFpf9x07Uio7NUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Loongson platform support spi hardware controller and this series patch
was to add spi driver and binding support.

Change in v2:
		1. This [PATCH v2 1/2] dt-bindings patch need depend on clk patch:
	 	   https://
		   lore.kernel.org/all/20230307115022.12846-1-zhuyinbo@loongson.cn/
		2. Remove the clock-names in spi yaml file.
		3. Add "loongson,ls7a-spi" compatible in spi yaml file.
		4. Add an || COMPILE_TEST and drop && PCI then add some CONFIG_PCI
		   macro to limit some pci code.
		5. Make the spi driver top code comment block that use C++ style.
		6. Drop spi->max_speed_hz.
		7. Add a spin_lock for loongson_spi_setup.
		8. Add a timeout and cpu_relax() in loongson_spi_write_read_8bit.
		9. Add spi_transfer_one and drop transfer and rework entire spi
		   driver that include some necessary changes.
		10. Use module_init replace subsys_initcall.
		11. About PM interface that I don't find any issue so I don't add
		    any changes.
Change in v3:
		1. This [PATCH v3 1/2] dt-bindings patch need depend on clk patch:
		   https://
		   lore.kernel.org/all/20230323025229.2971-1-zhuyinbo@loongson.cn/
		2. Drop the unused blank line in loongson,ls-spi.yaml file.
		3. Replace clock minItems with clock maxItems in yaml file.
		4. Separate spi driver into platform module, pci module and core
		   module.
		5. Replace DIV_ROUND_UP with DIV_ROUND_UP_ULL to fix compile error
		   "undefined reference to `__aeabi_uldivmod'" and  "__udivdi3 undefined"
		   that reported by test robot.
		6. Remove the spin lock.
		7. Clear the loongson_spi->hz and loongson_spi->mode in setup to fixup
		   the issue that multiple spi device transfer that maybe cause spi was
		   be misconfigured.
Change in v4:
		1. This [PATCH v4 1/2] dt-bindings patch need depend on clk patch:
		   https://
		   lore.kernel.org/all/20230323025229.2971-1-zhuyinbo@loongson.cn/
		2. Add "#include <linux/io.h>" in spi-loongson-core.c for fix the compile
		   issue which devm_ioremap no declaration.
		3. Add "EXPORT_SYMBOL_GPL(loongson_spi_dev_pm_ops)" in
		   spi-loongson-core.c for fix the compile issue which
		   loongson_spi_dev_pm_ops undefined.
Change in v5:
		1. Get rid of the clock patch's dependency and open-code the clock IDs.
		2. Fixup checkpatch issue that by installed ply and gitpython package
		   locally, but this series of patch's code doesn't have any change.
Change in v6:
		1. Remove the "#include <dt-bindings/clock/loongson,ls2k-clk.h>" in
		   yaml file.
Change in v7:
		1. Remove the "loongson,ls7a-spi" and change yaml file name as
		   "loongson,ls2k-spi.yaml".
		2. Use module_pci_driver and module_platform_driver to replace
		   module_init and module_exit.
		3. Drop ".owner	= THIS_MODULE" in spi platform driver.
		4. Add devm_spi_alloc_master devm_spi_register_master to simplify code.
		5. Add pci_disable_device() in loongson_spi_pci_unregister.
Change in v8:
		1. Add reviewed-by information for spi bindings patch.
		2. Fixup the uncorrect spi yaml file path in MAINTAINERS file.
		3. Add spi_master_suspend and spi_master_resume in spi pm function.
Change in v9:
		1. Make spi_master_suspend go first in pm suspend.
Change in v10:
		1. Fix the compile issue about of_node_get and of_get_property no
		   declaration.
		2. set config SPI_LOONGSON_CORE invisible.
		3. Captial "spi" in commit log and Kconfig file.
		4. Write header files in alphabetical order.
		5. Use clamp_val, GENMASK() and BIT() in spi clock setting.
		6. Optimize clock and mode setting code.
		7. Use readb_poll_timeout in loongson_spi_write_read_8bit.
		8. Remove some useless dmesg print.
		9. Use device_set_node replace of_node_get.
		10. Use dev_err_probe in code.
		11. Use devm_clk_get_optional replace devm_clk_get.
		12. Remove SPI_NO_CS for drop 2k500 non common type spi.
		13. Use pcim_enable_device() and pcim_iomap_regions() in spi pci
		    driver.
		14. Passing the remapped address in loongson_spi_init_master.
		15. Remove the useless goto flag "err_out".
		16. Use pci vendor id in pci_ids.h.
		17. Use devm_platform_ioremap_resource in spi platform driver.
		18. Remove the useless item in pci_device_id.
		19. Remove the inned comma in of_device_id.
		20. Add some headfile in spi_loongson.h.
		21. Remove the useless extern for loongson_spi_init_master in
		    spi_loongson.h.

Yinbo Zhu (2):
  dt-bindings: spi: add loongson spi
  spi: loongson: add bus driver for the loongson spi controller

 .../bindings/spi/loongson,ls2k-spi.yaml       |  41 +++
 MAINTAINERS                                   |  10 +
 drivers/spi/Kconfig                           |  26 ++
 drivers/spi/Makefile                          |   3 +
 drivers/spi/spi-loongson-core.c               | 279 ++++++++++++++++++
 drivers/spi/spi-loongson-pci.c                |  61 ++++
 drivers/spi/spi-loongson-plat.c               |  46 +++
 drivers/spi/spi-loongson.h                    |  47 +++
 8 files changed, 513 insertions(+)

-- 
2.20.1

