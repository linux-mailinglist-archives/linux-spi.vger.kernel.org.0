Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75EE85F326
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2019 09:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfGDHAa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Jul 2019 03:00:30 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41323 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfGDHAa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Jul 2019 03:00:30 -0400
Received: by mail-lf1-f68.google.com with SMTP id 62so3475550lfa.8
        for <linux-spi@vger.kernel.org>; Thu, 04 Jul 2019 00:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nFhFhaoBN7wHqqVu4wu7F+jb79uqvxMnu2JV5e2t1u8=;
        b=UMNElB82eIqxhJ5JedFraCufuiuVKtZYaQlCegRi2TjvR+KJNr/g+f8JkxSoF1nja4
         TiJzkdRBAXX2p08TfnVilM5MD9Gfy8xXwP9+88cmb+ZsLxOIcq9K+5OJh9AXe0wQEsAT
         r8hx9ciWk9LZr1wYgI/uShZ9RDiEXswK5bBvpZQSBN6QabLfYY7jG4EoaZwvM8mHwIYb
         0PiVv8r7cNKA/o5stbrmIAtSBO75wZZz9H8lS1t2NZ48VtY3RSyJ1/gWyiWa+qifchji
         G1qeoOCa6TLsaCXaPg/HmZAF0tttOJN161Efiwmiq3R/vXSTGoRX44wTsCDIfLUFEy9u
         i+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nFhFhaoBN7wHqqVu4wu7F+jb79uqvxMnu2JV5e2t1u8=;
        b=Y6I1ioAKhXlBPOY4NXCamaxPuVti8A7SjxmkR1BlTiWzEsU01tWe+RbgnLq8m7+t1H
         IsDQT+fEzFtheyGqiOgmoxHHoJS9DYzARkpUoaDYs2Rd1nEL0hwD5VyVw6SwTZLF/e83
         3szw//obiwMkjYP3TFOUxph3zef0nX4G+53milUqK0iYwHP4spa8QaI3Vl8O8lI5vfPj
         2UYh/3IOPe7cwkrmIobnYF7FmRXovnRvzSmIH/v5aAkfpIUf8L+b8fZRH/F56aQsIU+X
         AUcTvpD9i8gqhxgB8otfc6lfRGdiBz2hKsUebbe8nCyibZjivdhAOo1kkPF+fQ8yd2XS
         yihg==
X-Gm-Message-State: APjAAAWk3KxXUCmMLdcLCeVlZYrZLQO8QrHBVgxlySwQ+TPo0FqUDYXd
        YHMROVqM3yOsU2nS+VuJ4BrFACIAEGKivckCng63tQ==
X-Google-Smtp-Source: APXvYqxECK5pts7QUjN8OM+gDIMSkQ+1U5Taq40OHzXtr54kM6ak66pDTcZS3KSfoXOJYJt9pa3rzeEE9OZm+UyocGg=
X-Received: by 2002:a19:e006:: with SMTP id x6mr215391lfg.165.1562223628546;
 Thu, 04 Jul 2019 00:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190701172517.31641-1-linus.walleij@linaro.org>
In-Reply-To: <20190701172517.31641-1-linus.walleij@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Jul 2019 09:00:17 +0200
Message-ID: <CACRpkdaUTvMJ3tbuA7moyLjn_+6QbfJwm3UhLxA1-nh+A5y_KA@mail.gmail.com>
Subject: Re: [PATCH] Revert "spi: gpio: Don't request CS GPIO in DT use-case"
To:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

the proper fix is now upstream in Torvald's tree so you can drop/revert
this patch.

Yours,
Linus Walleij
