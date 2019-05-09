Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B59F218897
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2019 12:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfEIK4A (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 May 2019 06:56:00 -0400
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]:36350
        "EHLO cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfEIKz7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 May 2019 06:55:59 -0400
Received: from msmac.intern.sperl.org (account martin@sperl.org [10.10.10.11] verified)
  by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
  with ESMTPSA id 7764488; Thu, 09 May 2019 10:55:51 +0000
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] spi: Fix Raspberry Pi breakage
From:   kernel@martin.sperl.org
In-Reply-To: <20190509023005.19290-1-broonie@kernel.org>
Date:   Thu, 9 May 2019 12:56:05 +0200
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <E18C82B3-52AE-4650-B2FB-23E774AFB1FB@martin.sperl.org>
References: <20190509023005.19290-1-broonie@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        =?utf-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


> On 09.05.2019, at 04:30, Mark Brown <broonie@kernel.org> wrote:
> 
> This reverts commit c9ba7a16d0f1 (Release spi_res after finalizing
> message) which causes races during cleanup.
> 
> Reported-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Mark Brown <broonie@kernel.org>

I have just posted a possible mitigation patch.

@Nicolas + Noralf: please see if this solves both of your issues.

Note that the first one is the most essential.

Thanks,
	Martin

