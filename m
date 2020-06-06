Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62AF1F05DA
	for <lists+linux-spi@lfdr.de>; Sat,  6 Jun 2020 10:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgFFIus (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 6 Jun 2020 04:50:48 -0400
Received: from kernel.crashing.org ([76.164.61.194]:39652 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgFFIur (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 6 Jun 2020 04:50:47 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 0568ocqR031371
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 6 Jun 2020 03:50:43 -0500
Message-ID: <f8586b1dde855e5d1d682444949a4cf6e4671482.camel@kernel.crashing.org>
Subject: spi-oc-tiny.c and microwatt chip select
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
Date:   Sat, 06 Jun 2020 18:50:37 +1000
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi !

I've cooked up a little SPI controller VHDL for the Microwatt project
(https://github.com/antonblanchard/microwatt, though the SPI isnt
merged yet), to control the flash connected to the FPGA (it contains
the bitfile and the SW payload, such as Linux).

Now I could write yet-another bitbang driver for Linux for it, or I
could make my controller look like an existing one :) It's very simple,
but I should be able to make it look like spi-oc-tiny.c quite easily.

Now as for chip-selects... I could also add some concept of GPIOs,
write a simple MMIO GPIO controller etc... or I could for now make my
life easier and send a patch adding an extra register to control chip
select to spi-oc-tiny.c keyd off a device-tree property (or the
compatible property) :-)

Any objection to the "easy/fast" way :-) ?

Cheers,
Ben.

