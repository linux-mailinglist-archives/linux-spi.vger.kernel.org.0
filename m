Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862404F61F4
	for <lists+linux-spi@lfdr.de>; Wed,  6 Apr 2022 16:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbiDFOdQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 6 Apr 2022 10:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbiDFOcT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 6 Apr 2022 10:32:19 -0400
X-Greylist: delayed 525 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Apr 2022 03:52:39 PDT
Received: from mail.tkos.co.il (mail.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943796B4666
        for <linux-spi@vger.kernel.org>; Wed,  6 Apr 2022 03:52:39 -0700 (PDT)
Received: from tarshish (unknown [10.0.8.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id 1C9C3440605
        for <linux-spi@vger.kernel.org>; Wed,  6 Apr 2022 13:43:25 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1649241805;
        bh=TIVbimN2TuEsaOH2kllYlf/QxH77HDsYW0xp62PprPk=;
        h=From:To:Subject:Date:From;
        b=YVw4B3pMwfQXQWeH2UhB7BtccDOAAW38O1yUwa+KyNI2SeXP1ChMLBrKbAAiA/nc2
         bBNVdtMxEdAMtphB7GM+wZWLj22XzfOwpG2/eYEOFI+hsYMKmRTMHOdGZOINCFvAOL
         frF9QxmtDhy99Jjjvfx85boxb1CWMuTmifnuhkVncGPXbtuxcO2owPt6v7InVheeOj
         B9QVygHSQZtLGfaMhhVb/q/TlceslvgOJPEJjpL1ktq+JK92exogsWxtyFPf3X0/56
         z41ja19ACYu4kvMVIxEyT4eMKIK8HKJ1F2UIhAf8ITkfGbjFoGrG0y5UpjIr8AkJLS
         +V9x1vv+X3gHA==
User-agent: mu4e 1.6.10; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     linux-spi@vger.kernel.org
Subject: Change CPHA in the middle of transaction
Date:   Wed, 06 Apr 2022 13:38:57 +0300
Message-ID: <87sfqqfq54.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi linux-spi list,

I am trying to communicate with an SPI device that latches MOSI bits on the
rising edge of the clock, while MISO bits are latched on the falling
edge. Fortunately, MOSI and MISO bits are not simultaneous. So Tx/Rx
work if SPI master changes CPHA at the right time with chip-select asserted.

It looks like generic SPI code provides no way to flip CPHA for different
spi_transfer in the context of a single spi_message. At the drivers level,
some drivers program SPI mode per spi_transfer (e.g. spi-imx mx1/mx21/mx31
variants), while others do that per spi_message (e.g. spi-imx mx51 variant).

I can hack around the problem from userspace with manual control of the GPIO
chip-select signal, and separate spidev SPI_IOC_MESSAGE calls with
SPI_IOC_RD_MODE in between. Not very nice.

I think about adding SPI_RX_CPHA_FLIP mode bit for that. Hardware that
supports separate MISO/MOSI CPHA can program that permanently for spi_device
that needs it (is there any such SPI master?). If not, the driver flips CPHA
when spi_transfer tx_buf is NULL.

Would that be acceptable?

Any other suggestion?

Thanks,
baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
