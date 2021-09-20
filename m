Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695CF4112CB
	for <lists+linux-spi@lfdr.de>; Mon, 20 Sep 2021 12:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbhITKWC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Sep 2021 06:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbhITKWC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Sep 2021 06:22:02 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D920C061574
        for <linux-spi@vger.kernel.org>; Mon, 20 Sep 2021 03:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=A+AoEy0cT6yO3//EwCuIQK4wVPn4Fuy+Ky9EGMxmn/8=; b=qjah4jn1zozzRDAO6gym3Jv5y3
        9ooJMLrWhSZXTVlnye8GPVNz3dVALtRbrAY9gdeUhzy4MMxf1zppvHFfU6Tepb37QLyUQsx2zvXSc
        YUOo8dWI24337OvvhxUE1kZoyovQwa1zMLxr1N8avSnlvL9Rw7hS+STzWsD907XK/iEnPSF+N7NSQ
        n9on84FCxcaT6mlCxy/OtyM6Xg14Yst+2nt/un21nItgwqsVAg2VZxYiOh/zCYTZQsEvhduXhwmyo
        nNL0oUzPScQlstPJilkq19rA2OsiJ1pefdUd8Ifb4XEwUdIbKvsmoxiYWpk+i1vDEkEKOvk3bgiPG
        HOfrsr/w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54664)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mSGPW-0001WT-J0; Mon, 20 Sep 2021 11:20:31 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mSGPV-0002DZ-Qv; Mon, 20 Sep 2021 11:20:29 +0100
Date:   Mon, 20 Sep 2021 11:20:29 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     broonie@kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        Andreas Schwab <schwab@suse.de>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: REGRESSION: "spi: add of_device_uevent_modalias support" and
 following "fix" breaks Macchiatobin
Message-ID: <YUhgbW8CiYI/rm+y@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

Commit 3ce6c9e2617e ("spi: add of_device_uevent_modalias support")
prevents Macchiatobin auto-loading the spi-nor driver at boot.

Prior to this change, /sys/bus/spi/devices/spi4.0/uevent contained:

OF_COMPATIBLE_0=st,w25q32
OF_COMPATIBLE_N=1
MODALIAS=spi:w25q32

since the DT for this platform contains:

spi-flash@0 {
        compatible = "st,w25q32";

which is entirely legal according to the binding documentation in
Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml.

The above referenced commit changes this to:

MODALIAS=of:Nspi-flashT(null)Cst,w25q32

However, the spi-nor module only supports these "of" modaliases:

alias:          of:N*T*Cjedec,spi-norC*
alias:          of:N*T*Cjedec,spi-nor

but supports _way_ more "spi" modaliases, including "spi:w25q32".

Therefore, this change breaks module autoloading.

A following commit e09f2ab8eecc ("spi: update modalias_show after
of_device_uevent_modalias support") also changed the 
/sys/bus/spi/devices/spi4.0/modalias making a similar breaking change.

Hence there are two commits that may need to be reverted:

e09f2ab8eecc ("spi: update modalias_show after of_device_uevent_modalias support")
3ce6c9e2617e ("spi: add of_device_uevent_modalias support")

Alternatively, we need to add _all_ the flash types that the spi-nor
driver supports to the DT table, which sounds like a recipe for
disaster waiting to happen as it means maintaining two large tables of
flash devices, one for the SPI aliases with the flash information and
one for the DT aliases.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
