Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6FF8B77B
	for <lists+linux-spi@lfdr.de>; Tue, 13 Aug 2019 13:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfHMLrs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Aug 2019 07:47:48 -0400
Received: from muru.com ([72.249.23.125]:57216 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfHMLrs (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 13 Aug 2019 07:47:48 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5CEAD805C;
        Tue, 13 Aug 2019 11:48:15 +0000 (UTC)
Date:   Tue, 13 Aug 2019 04:47:44 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        letux-kernel@openphoenux.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/2] DTS: ARM: gta04: define chosen/stdout-path
Message-ID: <20190813114744.GT52127@atomide.com>
References: <cover.1562597164.git.hns@goldelico.com>
 <21ed570c5920346bf9dc1284c8dfee2e6ef79a51.1562597164.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21ed570c5920346bf9dc1284c8dfee2e6ef79a51.1562597164.git.hns@goldelico.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [190708 14:46]:
> This allows to remove the console= entry in the kernel command line.

Applying this patch into omap-for-v5.4/dt thanks.

Tony
