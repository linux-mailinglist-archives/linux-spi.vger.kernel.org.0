Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 198CA17654
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2019 12:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfEHKzZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 May 2019 06:55:25 -0400
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]:35940
        "EHLO cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfEHKzZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 May 2019 06:55:25 -0400
Received: from msmac.intern.sperl.org (account martin@sperl.org [10.10.10.11] verified)
  by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
  with ESMTPSA id 7764359; Wed, 08 May 2019 10:55:22 +0000
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH V2 5/6] spi: bcm2835: make the lower limit for dma mode configurable
From:   kernel@martin.sperl.org
In-Reply-To: <20190508084205.GD14916@sirena.org.uk>
Date:   Wed, 8 May 2019 12:55:32 +0200
Cc:     Lukas Wunner <lukas@wunner.de>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Message-Id: <CE110436-866D-44F4-B8A5-F7D02DD06F70@martin.sperl.org>
References: <20190423201513.8073-1-kernel@martin.sperl.org> <20190423201513.8073-6-kernel@martin.sperl.org> <20190424070712.hh6ozvhkvkxhwak3@wunner.de> <20190508084205.GD14916@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


> On 08.05.2019, at 10:42, Mark Brown <broonie@kernel.org> wrote:
> 
> especially with the ATMega case where we want fast individual clocks but
> lots of dead space in between bytes (is the controller capable of adding
> that dead space itself in DMA mode BTW?).

No it is not - at least not so far as I know of (and I just went over the
available documentation again).

Martin
