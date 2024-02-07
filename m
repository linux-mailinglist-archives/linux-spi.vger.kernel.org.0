Return-Path: <linux-spi+bounces-1184-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2077684D18A
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 19:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434E31C215B3
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 18:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D317012AAE0;
	Wed,  7 Feb 2024 18:43:27 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE591127B51
	for <linux-spi@vger.kernel.org>; Wed,  7 Feb 2024 18:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331407; cv=none; b=Me430UBgtbOWZyuprEtTqa9Jq82qQ8T/dnfvrK7KRHa2++PhsWh/Ci2TD1YqIKd6ugA9Wt13tcnMD2+mhx/F19FC46vV+l2+RnhMGCMqnceens1MiBkj2+FvD6DiYMbbKv3aP/dOtoJ6UVIoVRAKhtnEw40+SSUxNjFfVrS52qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331407; c=relaxed/simple;
	bh=lupNOJTfyldL3mmpGmFMUlRtxlv0yV5K01wD1FM//lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDhiBDmbYTK/Ofnv+xfAreqG4DcZkfgH74YFstUU0seqCMkLL8LaFVUg/CrBNNxR+PODkxJ9bsWQ3mWwW30UiKr+yhDJogaBK3Gj2Hw+L7nK1kMhu7DtHXHooddBsHA1wSB50n2Uxaqgngi5q+yAoofYysyUQ8zQ3ajW4INoIrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmtF-0008CF-2N; Wed, 07 Feb 2024 19:43:21 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmtE-0054Yq-I1; Wed, 07 Feb 2024 19:43:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmtE-00HRtx-1X;
	Wed, 07 Feb 2024 19:43:20 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 32/32] Documentation: spi: Update documentation for renaming "master" to "controller"
Date: Wed,  7 Feb 2024 19:40:46 +0100
Message-ID:  <3d643e22cacff12d3918ad5224baa1d01813d03b.1707324794.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707324793.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707324793.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=10646; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=lupNOJTfyldL3mmpGmFMUlRtxlv0yV5K01wD1FM//lU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlw87sFPC2ubYJeQTZiACVo+Y+sBdgqZYeH8PWh 9hnwOjmkoCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcPO7AAKCRCPgPtYfRL+ ToR2B/9ipdkmLVRM5BbNknVUv/GZaKE+W7/96VxDH3aIJElcdW3Dxbj3Ow7+KVu2H/ffas2Eg7W IFr9Hq0vYqwIYRDE4dTStFhKAQuV7Zl9XCq8jmJEaf2uxybCWs3VCjZkaAlod9QHvQhr2R2QeOS csGnlKxpQyPSQTGJJII7rQ8wgqbXVALzk2Oq3cAlas9NI7Xg8ZzUd+4qYTZBKoZFz0+E3cJDycU PggD4RMiFyrl31tfipCSBqbveM802kNc5+wfGvEsYbt6Yp7rwD8rCvdHs9vfn7U14VchIOSox3B qllTlYfFOqlQwXdm6UjwaHOpoLM9t7gAibGHLFmy1jr1M0Gb
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
some functions and struct members were renamed. Adapt the documentation
accordingly.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 Documentation/spi/spi-summary.rst | 74 +++++++++++++++----------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/Documentation/spi/spi-summary.rst b/Documentation/spi/spi-summary.rst
index 33f05901ccf3..e714472007f1 100644
--- a/Documentation/spi/spi-summary.rst
+++ b/Documentation/spi/spi-summary.rst
@@ -9,7 +9,7 @@ What is SPI?
 The "Serial Peripheral Interface" (SPI) is a synchronous four wire serial
 link used to connect microcontrollers to sensors, memory, and peripherals.
 It's a simple "de facto" standard, not complicated enough to acquire a
-standardization body.  SPI uses a master/slave configuration.
+standardization body.  SPI uses a host/target configuration.
 
 The three signal wires hold a clock (SCK, often on the order of 10 MHz),
 and parallel data lines with "Master Out, Slave In" (MOSI) or "Master In,
@@ -19,11 +19,11 @@ commonly used.  Each clock cycle shifts data out and data in; the clock
 doesn't cycle except when there is a data bit to shift.  Not all data bits
 are used though; not every protocol uses those full duplex capabilities.
 
-SPI masters use a fourth "chip select" line to activate a given SPI slave
+SPI hosts use a fourth "chip select" line to activate a given SPI slave
 device, so those three signal wires may be connected to several chips
 in parallel.  All SPI slaves support chipselects; they are usually active
 low signals, labeled nCSx for slave 'x' (e.g. nCS0).  Some devices have
-other signals, often including an interrupt to the master.
+other signals, often including an interrupt to the host.
 
 Unlike serial busses like USB or SMBus, even low level protocols for
 SPI slave functions are usually not interoperable between vendors
@@ -45,8 +45,8 @@ SPI slave functions are usually not interoperable between vendors
 
 In the same way, SPI slaves will only rarely support any kind of automatic
 discovery/enumeration protocol.  The tree of slave devices accessible from
-a given SPI master will normally be set up manually, with configuration
-tables.
+a given SPI host controller will normally be set up manually, with
+configuration tables.
 
 SPI is only one of the names used by such four-wire protocols, and
 most controllers have no problem handling "MicroWire" (think of it as
@@ -62,8 +62,8 @@ course they won't handle full duplex transfers.  You may find such
 chips described as using "three wire" signaling: SCK, data, nCSx.
 (That data line is sometimes called MOMI or SISO.)
 
-Microcontrollers often support both master and slave sides of the SPI
-protocol.  This document (and Linux) supports both the master and slave
+Microcontrollers often support both host and target sides of the SPI
+protocol.  This document (and Linux) supports both the host and target
 sides of SPI interactions.
 
 
@@ -118,7 +118,7 @@ starting low (CPOL=0) and data stabilized for sampling during the
 trailing clock edge (CPHA=1), that's SPI mode 1.
 
 Note that the clock mode is relevant as soon as the chipselect goes
-active.  So the master must set the clock to inactive before selecting
+active.  So the host must set the clock to inactive before selecting
 a slave, and the slave can tell the chosen polarity by sampling the
 clock level when its select line goes active.  That's why many devices
 support for example both modes 0 and 3:  they don't care about polarity,
@@ -179,7 +179,7 @@ shows up in sysfs in several locations::
    /sys/bus/spi/drivers/D ... driver for one or more spi*.* devices
 
    /sys/class/spi_master/spiB ... symlink to a logical node which could hold
-	class related state for the SPI master controller managing bus "B".
+	class related state for the SPI host controller managing bus "B".
 	All spiB.* devices share one physical SPI bus segment, with SCLK,
 	MOSI, and MISO.
 
@@ -316,7 +316,7 @@ sharing a bus with a device that interprets chipselect "backwards" is
 not possible until the infrastructure knows how to deselect it.
 
 Then your board initialization code would register that table with the SPI
-infrastructure, so that it's available later when the SPI master controller
+infrastructure, so that it's available later when the SPI host controller
 driver is registered::
 
 	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
@@ -474,34 +474,34 @@ How do I write an "SPI Master Controller Driver"?
 An SPI controller will probably be registered on the platform_bus; write
 a driver to bind to the device, whichever bus is involved.
 
-The main task of this type of driver is to provide an "spi_master".
-Use spi_alloc_master() to allocate the master, and spi_master_get_devdata()
-to get the driver-private data allocated for that device.
+The main task of this type of driver is to provide an "spi_controller".
+Use spi_alloc_host() to allocate the host controller, and
+spi_controller_get_devdata() to get the driver-private data allocated for that
+device.
 
 ::
 
-	struct spi_master	*master;
+	struct spi_controller	*ctlr;
 	struct CONTROLLER	*c;
 
-	master = spi_alloc_master(dev, sizeof *c);
-	if (!master)
+	ctlr = spi_alloc_host(dev, sizeof *c);
+	if (!ctlr)
 		return -ENODEV;
 
-	c = spi_master_get_devdata(master);
+	c = spi_controller_get_devdata(ctlr);
 
-The driver will initialize the fields of that spi_master, including the
-bus number (maybe the same as the platform device ID) and three methods
-used to interact with the SPI core and SPI protocol drivers.  It will
-also initialize its own internal state.  (See below about bus numbering
-and those methods.)
+The driver will initialize the fields of that spi_controller, including the bus
+number (maybe the same as the platform device ID) and three methods used to
+interact with the SPI core and SPI protocol drivers.  It will also initialize
+its own internal state.  (See below about bus numbering and those methods.)
 
-After you initialize the spi_master, then use spi_register_master() to
+After you initialize the spi_controller, then use spi_register_controller() to
 publish it to the rest of the system. At that time, device nodes for the
 controller and any predeclared spi devices will be made available, and
 the driver model core will take care of binding them to drivers.
 
-If you need to remove your SPI controller driver, spi_unregister_master()
-will reverse the effect of spi_register_master().
+If you need to remove your SPI controller driver, spi_unregister_controller()
+will reverse the effect of spi_register_controller().
 
 
 Bus Numbering
@@ -519,10 +519,10 @@ then be replaced by a dynamically assigned number. You'd then need to treat
 this as a non-static configuration (see above).
 
 
-SPI Master Methods
-^^^^^^^^^^^^^^^^^^
+SPI Host Controller Methods
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-``master->setup(struct spi_device *spi)``
+``ctlr->setup(struct spi_device *spi)``
 	This sets up the device clock rate, SPI mode, and word sizes.
 	Drivers may change the defaults provided by board_info, and then
 	call spi_setup(spi) to invoke this routine.  It may sleep.
@@ -534,34 +534,34 @@ SPI Master Methods
 	.. note::
 
 		BUG ALERT:  for some reason the first version of
-		many spi_master drivers seems to get this wrong.
+		many spi_controller drivers seems to get this wrong.
 		When you code setup(), ASSUME that the controller
 		is actively processing transfers for another device.
 
-``master->cleanup(struct spi_device *spi)``
+``ctlr->cleanup(struct spi_device *spi)``
 	Your controller driver may use spi_device.controller_state to hold
 	state it dynamically associates with that device.  If you do that,
 	be sure to provide the cleanup() method to free that state.
 
-``master->prepare_transfer_hardware(struct spi_master *master)``
+``ctlr->prepare_transfer_hardware(struct spi_controller *ctlr)``
 	This will be called by the queue mechanism to signal to the driver
 	that a message is coming in soon, so the subsystem requests the
 	driver to prepare the transfer hardware by issuing this call.
 	This may sleep.
 
-``master->unprepare_transfer_hardware(struct spi_master *master)``
+``ctlr->unprepare_transfer_hardware(struct spi_controller *ctlr)``
 	This will be called by the queue mechanism to signal to the driver
 	that there are no more messages pending in the queue and it may
 	relax the hardware (e.g. by power management calls). This may sleep.
 
-``master->transfer_one_message(struct spi_master *master, struct spi_message *mesg)``
+``ctlr->transfer_one_message(struct spi_controller *ctlr, struct spi_message *mesg)``
 	The subsystem calls the driver to transfer a single message while
 	queuing transfers that arrive in the meantime. When the driver is
 	finished with this message, it must call
 	spi_finalize_current_message() so the subsystem can issue the next
 	message. This may sleep.
 
-``master->transfer_one(struct spi_master *master, struct spi_device *spi, struct spi_transfer *transfer)``
+``ctrl->transfer_one(struct spi_controller *ctlr, struct spi_device *spi, struct spi_transfer *transfer)``
 	The subsystem calls the driver to transfer a single transfer while
 	queuing transfers that arrive in the meantime. When the driver is
 	finished with this transfer, it must call
@@ -576,15 +576,15 @@ SPI Master Methods
 	* 0: transfer is finished
 	* 1: transfer is still in progress
 
-``master->set_cs_timing(struct spi_device *spi, u8 setup_clk_cycles, u8 hold_clk_cycles, u8 inactive_clk_cycles)``
-	This method allows SPI client drivers to request SPI master controller
+``ctrl->set_cs_timing(struct spi_device *spi, u8 setup_clk_cycles, u8 hold_clk_cycles, u8 inactive_clk_cycles)``
+	This method allows SPI client drivers to request SPI host controller
 	for configuring device specific CS setup, hold and inactive timing
 	requirements.
 
 Deprecated Methods
 ^^^^^^^^^^^^^^^^^^
 
-``master->transfer(struct spi_device *spi, struct spi_message *message)``
+``ctrl->transfer(struct spi_device *spi, struct spi_message *message)``
 	This must not sleep. Its responsibility is to arrange that the
 	transfer happens and its complete() callback is issued. The two
 	will normally happen later, after other transfers complete, and
-- 
2.43.0


