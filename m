Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89D9D14950
	for <lists+linux-spi@lfdr.de>; Mon,  6 May 2019 14:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfEFMGi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 May 2019 08:06:38 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:35489 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfEFMGi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 May 2019 08:06:38 -0400
Received: from maxwell.fritz.box ([109.41.66.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MSI6i-1hH3rt3ezQ-00SbDV; Mon, 06 May 2019 14:06:34 +0200
From:   Jochen Henneberg <jh@henneberg-systemdesign.com>
To:     linux-spi@vger.kernel.org
Cc:     broonie@kernel.org
Subject: New driver for CP2130 USB-to-SPI bridge
Date:   Mon,  6 May 2019 14:06:19 +0200
Message-Id: <1557144380-19935-1-git-send-email-jh@henneberg-systemdesign.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:pfJG8vhO0bZrVBl20tq1bkOoXyJOBx4NGssbEuibVunULFJDuSi
 L0grAhc5bsPtpbF6+yPIA2aY4rAGOP2QcEj4LUmIrvU4qNYmEzEjPabRkQPw5A15w/V6/4g
 WIVSQphcqlMWIX05WQow9DwOVDNVu6zBVVJgofnKIzrdaZ7R2JmT6IsKo2o/oOFWRWSFodM
 scNTK/meQoqbQlXtQD0ZQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:185jNo76R+w=:21ArvGLAt1P7qrsHnToIPs
 hsjud8hmbg90WbX1lgzy2+VRmodvs2y3jRbVnwP6PJOL72IlzVYbjTkJw9wXRs9q1FqNohGNY
 2XgqFb++WE9WwqyhOoU/rOayMvOfAHssjqvmkv+FZekalXFrxg3HkzpRWyQr0pYAwaCaLm87w
 kygRjgRU5L+F3CuzAhvbvMOetx0ISOw+pCvxX3kjzGgD7L3/fJlt7eYl0EIaxt/v35L/IwWN4
 s8tRs1rKIUsSYI2VTIgMMV/Xfg6BlH5kbSHQMPbnfA556pjMZoXcoHUKcvraQ5xsxV+I3tf5h
 fqPsEZMnkeXbK8EYPu89Aghsw7yvzdG8BU2rInups3mNJZ9WMEd7FmYQfy3UN88SyMl1pytGe
 /yBrXO4kgMCbJ6754MEGdUlEkl7pVAQ1OWpdP32T0pAPGMb5D4ckTtvicSk4qOp8Lge7JKNaU
 d40eHiUBY0MBIO625V6qm5XBXGNjGsL7TFuyQJ1HNuLfrs+yaujo0umkLw4oZfx2FJ/gpioGy
 sN0kLSDDO8cvvGk0MY88feStGdZAhYd4v/1ENh1Dxcy1s2ZOB0n91MHpdP5nJ43UEvrI2zsfV
 pJcztSk5/25RXm2w2I7gjdWmYeEe70s5RGkc1vZVtfsPWB1YCDWMDzhWXegvn9XN/OwGoRNVN
 WHHQ0zq7vbleGuPP/srZoo2JBOSnyEobCEi+bUw1I1QEcLP5+3l9c6yfW8CzfrbxajAcA8T2d
 1VIoLXsS6eLGVRCh4uk0u7HYcZjakU24gVUHkuHenYGSByk0FOcGV9i2zOk=
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This is a new driver to support the Silicon Labs CP2130 USB-to-SPI
bridge. There are some warning left from checkpatch.pl but I would
consider those as false negatives as they will reduce code
readability.

The check script also suggests to edit the maintainers list. If this
helps I would be willing to provide maintenance for the driver. Just
let me know.

The driver has been used by several people as you can see from the
Github repository https://github.com/Henneberg-Systemdesign/cp2130[1][1].

I am using the driver with the MCP215x CAN controller, the Holt
HI-3593 transceiver and some Analog Devices DSPs.

