Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D07E8161A9
	for <lists+linux-spi@lfdr.de>; Tue,  7 May 2019 12:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfEGKHd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 May 2019 06:07:33 -0400
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]:35646
        "EHLO cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfEGKHc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 May 2019 06:07:32 -0400
Received: from msmac.intern.sperl.org (account martin@sperl.org [10.10.10.11] verified)
  by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
  with ESMTPSA id 7764261; Tue, 07 May 2019 10:07:30 +0000
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 3/5] spi: core: allow defining time that cs is deasserted as a multiple of SCK
From:   kernel@martin.sperl.org
In-Reply-To: <20190226113720.GB7082@sirena.org.uk>
Date:   Tue, 7 May 2019 12:07:35 +0200
Cc:     Lukas Wunner <lukas@wunner.de>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Message-Id: <E177DD3C-49B0-4319-A6F5-45DF9ED02070@martin.sperl.org>
References: <20190223084952.14758-1-kernel@martin.sperl.org> <20190223084952.14758-4-kernel@martin.sperl.org> <20190223124010.y7lsncknnxoblvgz@wunner.de> <CCC6392E-3189-49BE-B04D-3997434184D0@martin.sperl.org> <20190224103913.bjw7g6ievr75iawz@wunner.de> <0CA42E9E-3297-41EC-8E90-FAE937E892DE@martin.sperl.org> <20190226113720.GB7082@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


> On 26.02.2019, at 12:37, Mark Brown <broonie@kernel.org> wrote:
> 
> On Sun, Feb 24, 2019 at 12:03:33PM +0100, kernel@martin.sperl.org wrote:
> 
>> Some devices - like the mcp2517fd -  have for example an internal PLL
>> based on an external clock. So during setup you have to use speed_hz 
>> of <clock_hz> / 2 (or 4MHz at most) and only when PLL is in sync we 
>> may be using speed_hz from the dt (or less if a module parameter is
>> used to limit ourselves further)
> 
>> So the initial setup would not be able to help here - and every
>> bus controller would now be required to implement setup.
> 
>> It also means open coding the calculations in each driver that 
>> needs something like this.
> 
>> Thus it is - imo - in the right location to support it in spi core.
> 
> I agree, this feature makes sense to me.

Is there anything that really block this patch?

Do you want a rebase?
Anything else?

Martin
