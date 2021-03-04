Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CE932CE6D
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 09:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236740AbhCDI2N (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Mar 2021 03:28:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:50700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233025AbhCDI1t (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 4 Mar 2021 03:27:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD85264EEC;
        Thu,  4 Mar 2021 08:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614846429;
        bh=h2BcgeGmCIH5OV0KnmVpjP1ukfYz9GMQmLRR1QPhBd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I2FG0yfrM8gi/8X6Xy4jPA1wgrSMXtDE/xq5GckyAtFXgI2tg0wfZgo3UezKgCeW8
         /BdMvmfEJhJxmLR4O6b14h4GXzvRnOKl4emANlXDLhMYvguhot0jrM5oWLqejvhnHW
         hTsgcKfcY8eCAqPacCUa65IsrfqhrxdegjOJ8Uuk=
Date:   Thu, 4 Mar 2021 09:27:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] parport: Introduce module_parport_driver() and
 use it
Message-ID: <YECZ2oITT4sUptYF@kroah.com>
References: <20210303091642.23929-1-andriy.shevchenko@linux.intel.com>
 <20210303202432.GD5027@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303202432.GD5027@sirena.org.uk>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Mar 03, 2021 at 08:24:32PM +0000, Mark Brown wrote:
> On Wed, Mar 03, 2021 at 11:16:39AM +0200, Andy Shevchenko wrote:
> > Introduce module_parport_driver() and use it.
> > Greg or Mark, since we have this series tagged, can somebody of you pick it up?
> 
> Greg, are you OK with me applying this?

Yup, just sent a reviewed-by for it, thanks.

greg k-h
