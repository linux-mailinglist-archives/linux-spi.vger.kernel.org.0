Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DE721894F
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jul 2020 15:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbgGHNi4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jul 2020 09:38:56 -0400
Received: from mailout2.hostsharing.net ([83.223.78.233]:37193 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbgGHNi4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Jul 2020 09:38:56 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id D416B10189C99;
        Wed,  8 Jul 2020 15:30:00 +0200 (CEST)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 94A936106EC8;
        Wed,  8 Jul 2020 15:30:00 +0200 (CEST)
X-Mailbox-Line: From f2d349b5ba67b5ca70cb19577725167642eb69c5 Mon Sep 17 00:00:00 2001
Message-Id: <cover.1594214103.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Wed, 8 Jul 2020 15:27:00 +0200
Subject: [PATCH 0/3] Fix races on device removal
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Prevent dynamic SPI device addition below a controller which is
being removed.  To do so, set the controller's "dead" flag using
kill_device() (patch [3/3]).

Serialize access to a device's "dead" flag with a newly introduced
rw_semaphore in lieu of the device_lock to avoid deadlocks occurring
with the new use case (patch [2/3]).

Add a missing check for the "dead" flag upon driver binding
(patch [1/3]).


Lukas Wunner (3):
  driver core: Avoid binding drivers to dead devices
  driver core: Use rwsem for kill_device() serialization
  driver core: Avoid adding children below a dead parent

 drivers/base/base.h  |  2 ++
 drivers/base/core.c  | 49 ++++++++++++++++++++++++++++++--------------
 drivers/base/dd.c    | 12 ++++++++++-
 drivers/nvdimm/bus.c |  8 +-------
 drivers/spi/spi.c    |  3 +++
 5 files changed, 51 insertions(+), 23 deletions(-)

-- 
2.27.0

