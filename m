Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DD63B05F7
	for <lists+linux-spi@lfdr.de>; Tue, 22 Jun 2021 15:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhFVNm2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Jun 2021 09:42:28 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:38923 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhFVNm0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Jun 2021 09:42:26 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MnJQq-1lWDlt0aCi-00jLNb; Tue, 22 Jun 2021 15:40:09 +0200
Received: by mail-wm1-f53.google.com with SMTP id o33-20020a05600c5121b02901e360c98c08so52403wms.5;
        Tue, 22 Jun 2021 06:40:08 -0700 (PDT)
X-Gm-Message-State: AOAM532it2aS9Qjt1PnQd80roy7wyWxH9watKGIujFJwxKz0DvZbfEFh
        z5+UM4D817EArgTdUAF+3H/9JgOlRptY1tCRm0I=
X-Google-Smtp-Source: ABdhPJzm6xLY1LzxfJVjzpAuWWJivt4Xrbgr6yE13SVhdl1IZ1z4VN1BG5wxOqSc2yODn79ksNUEMWlvOjfXWZqlOWM=
X-Received: by 2002:a1c:a5ce:: with SMTP id o197mr4680368wme.84.1624369208699;
 Tue, 22 Jun 2021 06:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210621175359.126729-6-sebastian.reichel@collabora.com> <202106222109.fdao9FF0-lkp@intel.com>
In-Reply-To: <202106222109.fdao9FF0-lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 22 Jun 2021 15:37:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2CmYnE=S8RqxM-3bKYH+VvYxOpA2-jzBLYwftvvA614Q@mail.gmail.com>
Message-ID: <CAK8P3a2CmYnE=S8RqxM-3bKYH+VvYxOpA2-jzBLYwftvvA614Q@mail.gmail.com>
Subject: Re: [PATCHv5 5/5] misc: gehc-achc: new driver
To:     kernel test robot <lkp@intel.com>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, kbuild-all@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Ian Ray <ian.ray@ge.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:gCjwuv+558bexIlYzz+G1/iGaLKRIZ6JocYPKCPq2a8q0IhszNG
 Fza6HhuWHyZU/IWNV0/W2t0bkZjlZZN4BBLW8GX6u/0DVwWzAszOsCzxi6y6tidZ1rajIS5
 jzhqPLDsqP3hxBcm9hbXSytnWUpIAyiL03hwuSsZHNEAz3l4yMDvvJXfUjFiFWN/GmGySnj
 Q67mFWFnT67acoBrX1ooQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tK6VT9/1axY=:QzpiVIigh9cMEQjRf0C+1n
 +rxOQkRMPnGvPNCVIVv+MWD5pGldThRDLUlDACrtek7CVHc1SdL/jc+4/1dxJNpn7MqY19NPk
 9WVj/EgytxCx3ZEtIWJatDzKmbUnf65OzS+MLkAKDN4kyzLgjmwo3CauAvi3CRGYFRmS6hm9j
 aG02U5qk1O57Y2Rls0L3zrInO680Xqyt97Hd66CfaGBqTA4wB1Em8Wqi6V4SRzv2AwxIKR1Y5
 hfQvr18/9HvUoBG9nr2eB69w8Hgh71FkhxBRhmUCPfZoyZPxWAXYJg4z8cjSJUWJBS2gH85fw
 LsXIyKjqj2VyLpbvG40tvJnZW4c/WpcvLhbQIAUxMcpQ3gKEL7/Pq9OOpwgflITGJKbjbPa2C
 qhgZ3PJetrlWc4dGkwwEZ/yUFFrPWHFPaYoVXqhhKYoD6MXxe89uVPUxDd9KWRwHX/zg3myp1
 uR0+MnnDhq1/HLZcCY0PSWUbjCijuWpZ2QXJeZX4KLd8sQeKc/3f/IHb0a25vXhChzTowTFf+
 CwpVVzxOy1RDrvqnAvYees=
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Jun 22, 2021 at 3:30 PM kernel test robot <lkp@intel.com> wrote:
>
>
> ERROR: modpost: missing MODULE_LICENSE() in drivers/misc/nxp-ezport.o
> >> ERROR: modpost: "ezport_flash" [drivers/misc/gehc-achc.ko] undefined!
> >> ERROR: modpost: "ezport_reset" [drivers/misc/gehc-achc.ko] undefined!

It looks like this was only tested as a built-in driver. The easiest way would
be to change the Makefile to link both files into a combined driver module,
such as

obj-$(CONFIG_GEHC_ACHC)           += gehc-achc-mod.o
gehc-achc-mod.o                                += gehc-achc.o nxp-ezport.o

       Arnd
