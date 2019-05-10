Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6F8419B0E
	for <lists+linux-spi@lfdr.de>; Fri, 10 May 2019 12:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfEJKLl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 May 2019 06:11:41 -0400
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]:36718
        "EHLO cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbfEJKLl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 May 2019 06:11:41 -0400
Received: from msmac.intern.sperl.org (account martin@sperl.org [10.10.10.11] verified)
  by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
  with ESMTPSA id 7764625; Fri, 10 May 2019 10:11:38 +0000
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] spi: bcm2835: Remove spi_alloc_master() error printing
From:   Martin Sperl <martin@sperl.org>
In-Reply-To: <1557477738-20634-1-git-send-email-na-hoan@jinso.co.jp>
Date:   Fri, 10 May 2019 12:11:56 +0200
Cc:     Mark Brown <broonie@kernel.org>,
        linux-rpi-kernel@lists.infradead.org, eric@anholt.net,
        stefan.wahren@i2se.com, linux-spi@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <8770EAC3-A449-4A33-8635-7039FDC83B51@sperl.org>
References: <1557477738-20634-1-git-send-email-na-hoan@jinso.co.jp>
To:     Nguyen An Hoan <na-hoan@jinso.co.jp>
X-Mailer: Apple Mail (2.3124)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


> On 10.05.2019, at 10:42, Nguyen An Hoan <na-hoan@jinso.co.jp> wrote:
> 
> From: Hoan Nguyen An <na-hoan@jinso.co.jp>
> 
> Printing an error on memory allocation failure is unnecessary,
> as the memory allocation core code already takes care of that.
> 
> Signed-off-by: Hoan Nguyen An <na-hoan@jinso.co.jp>
Reviewed-by: Martin Sperl <kernel@martin.sperl.org>

