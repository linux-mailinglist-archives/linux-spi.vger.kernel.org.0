Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70CE1F06A0
	for <lists+linux-spi@lfdr.de>; Sat,  6 Jun 2020 15:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgFFNCz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 6 Jun 2020 09:02:55 -0400
Received: from kernel.crashing.org ([76.164.61.194]:39748 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgFFNCz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 6 Jun 2020 09:02:55 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 056D2kVK001326
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 6 Jun 2020 08:02:50 -0500
Message-ID: <06ac360bfb039a71bd4048954af3c3300a54a3c6.camel@kernel.crashing.org>
Subject: Re: spi-oc-tiny.c and microwatt chip select
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
Date:   Sat, 06 Jun 2020 23:02:46 +1000
In-Reply-To: <20200606113716.GA2055@sirena.org.uk>
References: <f8586b1dde855e5d1d682444949a4cf6e4671482.camel@kernel.crashing.org>
         <20200606113716.GA2055@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 2020-06-06 at 12:37 +0100, Mark Brown wrote:
> On Sat, Jun 06, 2020 at 06:50:37PM +1000, Benjamin Herrenschmidt
> wrote:
> 
> > Now as for chip-selects... I could also add some concept of GPIOs,
> > write a simple MMIO GPIO controller etc... or I could for now make
> > my
> > life easier and send a patch adding an extra register to control
> > chip
> > select to spi-oc-tiny.c keyd off a device-tree property (or the
> > compatible property) :-)
> > Any objection to the "easy/fast" way :-) ?
> 
> That sounds fine (I'd go with a different compatible).

Great ! Thanks.

Cheers,
Ben.


