Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694D21F065A
	for <lists+linux-spi@lfdr.de>; Sat,  6 Jun 2020 13:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbgFFL2B (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 6 Jun 2020 07:28:01 -0400
Received: from kernel.crashing.org ([76.164.61.194]:39722 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgFFL2B (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 6 Jun 2020 07:28:01 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 056BRtO9000336
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-spi@vger.kernel.org>; Sat, 6 Jun 2020 06:27:59 -0500
Message-ID: <27de874d84efb0314756ad4bcb8eeaf263a8951b.camel@kernel.crashing.org>
Subject: CS# timings
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     linux-spi@vger.kernel.org
Date:   Sat, 06 Jun 2020 21:27:55 +1000
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi !

I noticed that nothing in tree calls spi_set_cs_timing()

Did I miss some subtle macro trick defeating my grep ? Or is no driver
putting any requirements on CS# assertion/release and delay between
them ?

For example, the Spansion flash I'm looking at (S25FL128S) has a tCS
(delay between commands basically) of 50ns for program or erase
commands, which is quite significant.

Do we do anything to ensure this isn't violated ?

Cheers,
Ben.


