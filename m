Return-Path: <linux-spi+bounces-5925-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B78DF9E6B5E
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2024 11:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73D45280CC3
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2024 10:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5CA1DD0E7;
	Fri,  6 Dec 2024 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x0bts9uL"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07311DC182
	for <linux-spi@vger.kernel.org>; Fri,  6 Dec 2024 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733479919; cv=none; b=oFJl6IiOfotxQf4Avvi/+aizJdwrJFYmQxcpwOgqw7lNdGp+n+42uZkRur9m7PM3fCFsnhK21D+2ShAyT1xw1jVMgjLKCqkwsUTMXBKyZ8dB2aiL9S/c3DRdZd1drYBq3hd3Xf12TClY3gb2aohVjLHoqa6w7uyinq343jJu1Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733479919; c=relaxed/simple;
	bh=MvThOOeFftwfKuEkJZuJqhHQ0eFnVIjFnKln4pRaq1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ncwLRlVBGPdqQfdtUzYOx63CcONVK/05cpM5vk9dBuXq5qgRkcvoE/TADbrOa//7g/SKap5HjJ1B3oz9Xj85GfdjG8WJMMMqgFc+aJorshxLK4V9DZ2Y5n2w/K9WYnPLX+851mn0IzzJUWlCuoGeML55HWGm2NAXS7ZlHYFfV9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x0bts9uL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4349e1467fbso12620425e9.1
        for <linux-spi@vger.kernel.org>; Fri, 06 Dec 2024 02:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733479915; x=1734084715; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4gmMgvDBk/2jXYB7Jw3F4XI+kY9z+9TJCJLTtpMvb7I=;
        b=x0bts9uLRBgYnCzP6QVajJSyrkt7DgpuSHvLSHIKUJPVYYNMznIGg2PMwA8fFfJGzJ
         OLbi/VoRS+MW0C38LSK08U5wQ7MB6kils6rYXxC2zb3FnVAFwsdv9bj3pd33K10lbiPG
         gBHYM9aw/mFBmXkQ537Oym97iXyG0odM6M/3BJ0i36p6ksDnH+b2FcBaCvYSOxd9Gnn0
         I81WaDeE5uv4d7FiSWBg+Sd/Aj6PSg6/b4PdcfZFz+KogWwOummfAQAAD8luakIuRu8a
         CY00cmshvt/XyVOS8Idcqz77cGfFY1YNRIJ/Gaaae+muh0MqrP5X0abJlRXmDwqW8Lj6
         f5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733479915; x=1734084715;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4gmMgvDBk/2jXYB7Jw3F4XI+kY9z+9TJCJLTtpMvb7I=;
        b=WeudcQ3baqO4lErj7oEMr76ncicYOV92sD+iR5vEwMBdoiVds+4vZaBICTWy51qCBd
         z5T0bxhRjzah62n/ggkCjPbE+GNgVgs9yq2iAtRAdm1C60Kl182Pvmkxawv1AqdCO09x
         AlypyClQXonvVSmFwDl401kNb456n0aR0YagfIthwWM09AjGPlxzr+/kER/0ZmtassIm
         dy1wysOJHzUTpTsR6+g188Wv+K1SUleK0jgslWelYBSZ8XSmkCb8lsN/CBAMwMVqMNYr
         0E6ooKoenxgJRTkhFOzY9QkwGOUMXUmUwo8vY4XAskqnQZVnge2zGpoLBc/FYHmhnpzC
         vXKg==
X-Gm-Message-State: AOJu0YyuiqJAGfbwKcKMKu2dlcwcmQLhueXIAu+zAEvsfu7i6UWp556y
	4qqTSkj0D9UEATpDntQBbUU8zUM5/HPkbD6/vCDmXvWMNsVLPYRpx8sctUHpaPc=
X-Gm-Gg: ASbGnctbTQUnnknKT01RQKLjt9dtknP9dVoPumomHSPm4zYl3pw6EgiwSDZzQhe8B7i
	1Ggo/s9JQjc8vM1zb6AIKptue9KtCTPl0Ggr/OOUC1oJplxAWXG/r+3ufMbhrRQhBKqc2zHN3YU
	rhu57rwl55I3xvlRMWepI6i9CaHG7wC78Ca4DTe3WZWqd6LAKy4Gl3ZKCjRr2H1VxagTUhgBiP5
	hSPN17+SuXK18GaB0aQg3jJoRCxE3dldLiOxvAgZIxUBtVzo4/z844=
X-Google-Smtp-Source: AGHT+IG2JobuQAFJZbXZhpTZhtOlC9xEC1tbx7qHSQOap8UrZu0Zc9YT9zlAIAHHqkDUNx1DXEK5Jg==
X-Received: by 2002:a05:600c:5107:b0:434:a902:97cd with SMTP id 5b1f17b1804b1-434ddeacb51mr20565645e9.12.1733479915257;
        Fri, 06 Dec 2024 02:11:55 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52732casm89792715e9.13.2024.12.06.02.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 02:11:54 -0800 (PST)
Date: Fri, 6 Dec 2024 13:11:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Srikanth Boyapally <srikanth.boyapally@amd.com>
Cc: linux-spi@vger.kernel.org
Subject: [bug report] spi: cadence-quadspi: Support for device reset via OSPI
 controller
Message-ID: <a9ef0b09-8eb6-498f-810d-26ff72801669@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Srikanth Boyapally,

Commit 27cf57f65bea ("spi: cadence-quadspi: Support for device reset
via OSPI controller") from Nov 20, 2024 (linux-next), leads to the
following Smatch static checker warning:

	drivers/spi/spi-cadence-quadspi.c:1937 cqspi_probe()
	error: we previously assumed 'ddata' could be null (see line 1882)

drivers/spi/spi-cadence-quadspi.c
    1765 static int cqspi_probe(struct platform_device *pdev)
    1766 {
    1767         const struct cqspi_driver_platdata *ddata;
    1768         struct reset_control *rstc, *rstc_ocp, *rstc_ref;
    1769         struct device *dev = &pdev->dev;
    1770         struct spi_controller *host;
    1771         struct resource *res_ahb;
    1772         struct cqspi_st *cqspi;
    1773         int ret;
    1774         int irq;
    1775 
    1776         host = devm_spi_alloc_host(&pdev->dev, sizeof(*cqspi));
    1777         if (!host)
    1778                 return -ENOMEM;
    1779 
    1780         host->mode_bits = SPI_RX_QUAD | SPI_RX_DUAL;
    1781         host->mem_ops = &cqspi_mem_ops;
    1782         host->mem_caps = &cqspi_mem_caps;
    1783         host->dev.of_node = pdev->dev.of_node;
    1784 
    1785         cqspi = spi_controller_get_devdata(host);
    1786 
    1787         cqspi->pdev = pdev;
    1788         cqspi->host = host;
    1789         cqspi->is_jh7110 = false;
    1790         cqspi->ddata = ddata = of_device_get_match_data(dev);
                                ^^^^^^^
ddata set here

    1791         platform_set_drvdata(pdev, cqspi);
    1792 
    1793         /* Obtain configuration from OF. */
    1794         ret = cqspi_of_get_pdata(cqspi);
    1795         if (ret) {
    1796                 dev_err(dev, "Cannot get mandatory OF data.\n");
    1797                 return -ENODEV;
    1798         }
    1799 
    1800         /* Obtain QSPI clock. */
    1801         cqspi->clk = devm_clk_get(dev, NULL);
    1802         if (IS_ERR(cqspi->clk)) {
    1803                 dev_err(dev, "Cannot claim QSPI clock.\n");
    1804                 ret = PTR_ERR(cqspi->clk);
    1805                 return ret;
    1806         }
    1807 
    1808         /* Obtain and remap controller address. */
    1809         cqspi->iobase = devm_platform_ioremap_resource(pdev, 0);
    1810         if (IS_ERR(cqspi->iobase)) {
    1811                 dev_err(dev, "Cannot remap controller address.\n");
    1812                 ret = PTR_ERR(cqspi->iobase);
    1813                 return ret;
    1814         }
    1815 
    1816         /* Obtain and remap AHB address. */
    1817         cqspi->ahb_base = devm_platform_get_and_ioremap_resource(pdev, 1, &res_ahb);
    1818         if (IS_ERR(cqspi->ahb_base)) {
    1819                 dev_err(dev, "Cannot remap AHB address.\n");
    1820                 ret = PTR_ERR(cqspi->ahb_base);
    1821                 return ret;
    1822         }
    1823         cqspi->mmap_phys_base = (dma_addr_t)res_ahb->start;
    1824         cqspi->ahb_size = resource_size(res_ahb);
    1825 
    1826         init_completion(&cqspi->transfer_complete);
    1827 
    1828         /* Obtain IRQ line. */
    1829         irq = platform_get_irq(pdev, 0);
    1830         if (irq < 0)
    1831                 return -ENXIO;
    1832 
    1833         ret = pm_runtime_set_active(dev);
    1834         if (ret)
    1835                 return ret;
    1836 
    1837 
    1838         ret = clk_prepare_enable(cqspi->clk);
    1839         if (ret) {
    1840                 dev_err(dev, "Cannot enable QSPI clock.\n");
    1841                 goto probe_clk_failed;
    1842         }
    1843 
    1844         /* Obtain QSPI reset control */
    1845         rstc = devm_reset_control_get_optional_exclusive(dev, "qspi");
    1846         if (IS_ERR(rstc)) {
    1847                 ret = PTR_ERR(rstc);
    1848                 dev_err(dev, "Cannot get QSPI reset.\n");
    1849                 goto probe_reset_failed;
    1850         }
    1851 
    1852         rstc_ocp = devm_reset_control_get_optional_exclusive(dev, "qspi-ocp");
    1853         if (IS_ERR(rstc_ocp)) {
    1854                 ret = PTR_ERR(rstc_ocp);
    1855                 dev_err(dev, "Cannot get QSPI OCP reset.\n");
    1856                 goto probe_reset_failed;
    1857         }
    1858 
    1859         if (of_device_is_compatible(pdev->dev.of_node, "starfive,jh7110-qspi")) {
    1860                 rstc_ref = devm_reset_control_get_optional_exclusive(dev, "rstc_ref");
    1861                 if (IS_ERR(rstc_ref)) {
    1862                         ret = PTR_ERR(rstc_ref);
    1863                         dev_err(dev, "Cannot get QSPI REF reset.\n");
    1864                         goto probe_reset_failed;
    1865                 }
    1866                 reset_control_assert(rstc_ref);
    1867                 reset_control_deassert(rstc_ref);
    1868         }
    1869 
    1870         reset_control_assert(rstc);
    1871         reset_control_deassert(rstc);
    1872 
    1873         reset_control_assert(rstc_ocp);
    1874         reset_control_deassert(rstc_ocp);
    1875 
    1876         cqspi->master_ref_clk_hz = clk_get_rate(cqspi->clk);
    1877         host->max_speed_hz = cqspi->master_ref_clk_hz;
    1878 
    1879         /* write completion is supported by default */
    1880         cqspi->wr_completion = true;
    1881 
    1882         if (ddata) {
                     ^^^^^
I think this NULL check is correct.

    1883                 if (ddata->quirks & CQSPI_NEEDS_WR_DELAY)
    1884                         cqspi->wr_delay = 50 * DIV_ROUND_UP(NSEC_PER_SEC,
    1885                                                 cqspi->master_ref_clk_hz);
    1886                 if (ddata->hwcaps_mask & CQSPI_SUPPORTS_OCTAL)
    1887                         host->mode_bits |= SPI_RX_OCTAL | SPI_TX_OCTAL;
    1888                 if (!(ddata->quirks & CQSPI_DISABLE_DAC_MODE)) {
    1889                         cqspi->use_direct_mode = true;
    1890                         cqspi->use_direct_mode_wr = true;
    1891                 }
    1892                 if (ddata->quirks & CQSPI_SUPPORT_EXTERNAL_DMA)
    1893                         cqspi->use_dma_read = true;
    1894                 if (ddata->quirks & CQSPI_NO_SUPPORT_WR_COMPLETION)
    1895                         cqspi->wr_completion = false;
    1896                 if (ddata->quirks & CQSPI_SLOW_SRAM)
    1897                         cqspi->slow_sram = true;
    1898                 if (ddata->quirks & CQSPI_NEEDS_APB_AHB_HAZARD_WAR)
    1899                         cqspi->apb_ahb_hazard = true;
    1900 
    1901                 if (ddata->jh7110_clk_init) {
    1902                         ret = cqspi_jh7110_clk_init(pdev, cqspi);
    1903                         if (ret)
    1904                                 goto probe_reset_failed;
    1905                 }
    1906 
    1907                 if (ddata->quirks & CQSPI_DMA_SET_MASK) {
    1908                         ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
    1909                         if (ret)
    1910                                 goto probe_reset_failed;
    1911                 }
    1912         }
    1913 
    1914         ret = devm_request_irq(dev, irq, cqspi_irq_handler, 0,
    1915                                pdev->name, cqspi);
    1916         if (ret) {
    1917                 dev_err(dev, "Cannot request IRQ.\n");
    1918                 goto probe_reset_failed;
    1919         }
    1920 
    1921         cqspi_wait_idle(cqspi);
    1922         cqspi_controller_enable(cqspi, 0);
    1923         cqspi_controller_detect_fifo_depth(cqspi);
    1924         cqspi_controller_init(cqspi);
    1925         cqspi_controller_enable(cqspi, 1);
    1926         cqspi->current_cs = -1;
    1927         cqspi->sclk = 0;
    1928 
    1929         ret = cqspi_setup_flash(cqspi);
    1930         if (ret) {
    1931                 dev_err(dev, "failed to setup flash parameters %d\n", ret);
    1932                 goto probe_setup_failed;
    1933         }
    1934 
    1935         host->num_chipselect = cqspi->num_chipselect;
    1936 
--> 1937         if (ddata->quirks & CQSPI_SUPPORT_DEVICE_RESET)
                     ^^^^^^^^^^^^^
Unchecked dereference.

    1938                 cqspi_device_reset(cqspi);
    1939 
    1940         if (cqspi->use_direct_mode) {
    1941                 ret = cqspi_request_mmap_dma(cqspi);
    1942                 if (ret == -EPROBE_DEFER)
    1943                         goto probe_setup_failed;
    1944         }
    1945 
    1946         ret = devm_pm_runtime_enable(dev);
    1947         if (ret) {
    1948                 if (cqspi->rx_chan)
    1949                         dma_release_channel(cqspi->rx_chan);
    1950                 goto probe_setup_failed;
    1951         }
    1952 
    1953         pm_runtime_set_autosuspend_delay(dev, CQSPI_AUTOSUSPEND_TIMEOUT);
    1954         pm_runtime_use_autosuspend(dev);
    1955         pm_runtime_get_noresume(dev);
    1956 
    1957         ret = spi_register_controller(host);
    1958         if (ret) {
    1959                 dev_err(&pdev->dev, "failed to register SPI ctlr %d\n", ret);
    1960                 goto probe_setup_failed;
    1961         }
    1962 
    1963         pm_runtime_mark_last_busy(dev);
    1964         pm_runtime_put_autosuspend(dev);
    1965 
    1966         return 0;
    1967 probe_setup_failed:
    1968         cqspi_controller_enable(cqspi, 0);
    1969 probe_reset_failed:
    1970         if (cqspi->is_jh7110)
    1971                 cqspi_jh7110_disable_clk(pdev, cqspi);
    1972         clk_disable_unprepare(cqspi->clk);
    1973 probe_clk_failed:
    1974         return ret;
    1975 }

regards,
dan carpenter

